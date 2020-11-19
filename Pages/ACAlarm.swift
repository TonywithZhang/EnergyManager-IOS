//
//  ACAlarm.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/5.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ACAlarm: View {
    @State private var startTime = Date()
    @State private var showStartTimePicker = false
    @State private var startTimeText = "起始时间"
    @State private var endTime = Date()
    @State private var showEndTimePicker = false
    @State private var endTimeText = "截止时间"
    
    @State private var cityData = [AlarmInformation]()
    @State private var photoData = [AlarmInformation]()
    @State private var storageData = [AlarmInformation]()
    @State private var pileData = [AlarmInformation]()
    @State private var userData = [AlarmInformation]()
    var body: some View {
        ScrollView {
            VStack {
                //市电报警源
                VStack {
                    //市电图表
                    VStack {
                        HStack(spacing : 0) {
                            Text("市电")
                            Spacer()
                            TextField("起始时间", text: $startTimeText).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker,onDismiss:{
                                    self.startTimeText = "\(startTime.year)-\(startTime.month)-\(startTime.day)"
                                }, content: {
                                    startTimePicker
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker,onDismiss:{
                                    self.endTimeText = "\(endTime.year)-\(endTime.month)-\(endTime.day)"
                                }, content: {
                                    endTimePicker
                                })
                            Button(action : {
                                getData()
                            }){
                                Text("查询").font(.headline).foregroundColor(.white)
                            }.background(Rectangle().fill(Color.blue))
                        }.frame(height : 30)
                        AlarmTable(data: $cityData)
                            .frame(minHeight : 200,maxHeight: 250)
                        Spacer()
                    }
                    
                    Color.gray.frame(height : 2)
                    //光伏信息
                    VStack {
                        HStack(spacing : 0) {
                            Text("光伏")
                            Spacer()
                        }
                        AlarmTable(data: $photoData)
                            .frame(minHeight : 200,maxHeight: 250)
                    }
                    Color.gray.frame(height : 2)
                    //储能信息
                    VStack {
                        HStack(spacing : 0) {
                            Text("调峰储能")
                            Spacer()
                        }
                        AlarmTable(data: $storageData)
                            .frame(minHeight : 200,maxHeight: 250)
                    }
                    Color.gray.frame(height : 2)
                    //充电桩信息
                    VStack {
                        HStack(spacing : 0) {
                            Text("充电桩")
                            Spacer()
                        }
                        AlarmTable(data: $pileData)
                            .frame(minHeight : 100,maxHeight: 210)
                    }
                    Color.gray.frame(height : 2)
                    //用户信息
                    VStack {
                        HStack(spacing : 0) {
                            Text("用户")
                            Spacer()
                        }
                        AlarmTable(data: $userData)
                            .frame(minHeight : 200,maxHeight: 250)
                    }
                }
            }
        }
    }
    private var startTimePicker : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private func getData(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("http://101.132.236.192:8008/SysManage/Alarm/GetList",
                                 method : .post, parameters: [
                                    "StartDate" : "\(startTimeText) 00:00:00",
                                    "EndDate" : "\(endTimeText) 00:00:00",
                                    "page" : "1",
                                    "limit" : "10"
                                 ], headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                do{
                    let json = try JSON(data : data)
                    var photoList = [AlarmInformation]()
                    var cityList = [AlarmInformation]()
                    var storageList = [AlarmInformation]()
                    var pileList = [AlarmInformation]()
                    var userList = [AlarmInformation]()
                    let dataList = json["data"].arrayValue
                    for index in 0 ..< dataList.count {
                        let alarmData = dataList[index]
                        let alarm = AlarmInformation(time: alarmData["CreateTime"].stringValue,
                                                     state: String(alarmData["State"].intValue),
                                                     resource: alarmData["AlarmSource"].stringValue,
                                                     information: alarmData["Message"].stringValue)
                        switch alarmData["Category"] {
                        case "交流光伏":
                            photoList.append(alarm)
                        case "市电":
                            cityList.append(alarm)
                        case "调峰储能":
                            storageList.append(alarm)
                        case "充电桩":
                            pileList.append(alarm)
                        case "用户":
                            userList.append(alarm)
                        default:
                            debugPrint("其他类型的警报")
                        }
                        
                    }
                    cityData = cityList
                    photoData = photoList
                    storageData = storageList
                    pileData = pileList
                    userData = userList
                    debugPrint(cityData.count)
                    debugPrint(photoData.count)
                    debugPrint(storageData.count)
                    debugPrint(pileData.count)
                    debugPrint(userData.count)
                }catch{
                    debugPrint("解析json发生异常")
                }
            case .failure(_):
                debugPrint("报警数据网络请求失败")
            }
        }
    }
}

struct ACAlarm_Previews: PreviewProvider {
    static var previews: some View {
        ACAlarm()
    }
}
