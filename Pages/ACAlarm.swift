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
    @State private var startTime1 = Date()
    @State private var showStartTimePicker1 = false
    @State private var startTimeText1 = "起始时间"
    @State private var endTime1 = Date()
    @State private var showEndTimePicker1 = false
    @State private var endTimeText1 = "截止时间"
    
    @State private var startTime2 = Date()
    @State private var showStartTimePicker2 = false
    @State private var startTimeText2 = "起始时间"
    @State private var endTime2 = Date()
    @State private var showEndTimePicker2 = false
    @State private var endTimeText2 = "截止时间"
    
    @State private var startTime3 = Date()
    @State private var showStartTimePicker3 = false
    @State private var startTimeText3 = "起始时间"
    @State private var endTime3 = Date()
    @State private var showEndTimePicker3 = false
    @State private var endTimeText3 = "截止时间"
    
    @State private var startTime4 = Date()
    @State private var showStartTimePicker4 = false
    @State private var startTimeText4 = "起始时间"
    @State private var endTime4 = Date()
    @State private var showEndTimePicker4 = false
    @State private var endTimeText4 = "截止时间"
    
    @State private var startTime5 = Date()
    @State private var showStartTimePicker5 = false
    @State private var startTimeText5 = "起始时间"
    @State private var endTime5 = Date()
    @State private var showEndTimePicker5 = false
    @State private var endTimeText5 = "截止时间"
    
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
                            TextField("起始时间", text: $startTimeText1).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker1.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker1,onDismiss:{
                                    self.startTimeText1 = "\(startTime1.year)-\(startTime1.month)-\(startTime1.day)"
                                }, content: {
                                    startTimePicker1
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText1).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker1.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker1,onDismiss:{
                                    self.endTimeText1 = "\(endTime1.year)-\(endTime1.month)-\(endTime1.day)"
                                }, content: {
                                    endTimePicker1
                                })
                            Button(action : {
                                getData(index: 1, startTime: startTimeText1, endTime: endTimeText1)
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
                            TextField("起始时间", text: $startTimeText2).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker2.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker2,onDismiss:{
                                    self.startTimeText2 = "\(startTime2.year)-\(startTime2.month)-\(startTime2.day)"
                                }, content: {
                                    startTimePicker2
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText2).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker2.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker2,onDismiss:{
                                    self.endTimeText2 = "\(endTime2.year)-\(endTime2.month)-\(endTime2.day)"
                                }, content: {
                                    endTimePicker2
                                })
                            Button(action : {
                                getData(index: 2, startTime: startTimeText2, endTime: endTimeText2)
                            }){
                                Text("查询").font(.headline).foregroundColor(.white)
                            }.background(Rectangle().fill(Color.blue))
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
                            TextField("起始时间", text: $startTimeText3).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker3.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker3,onDismiss:{
                                    self.startTimeText3 = "\(startTime3.year)-\(startTime3.month)-\(startTime3.day)"
                                }, content: {
                                    startTimePicker3
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText3).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker3.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker3,onDismiss:{
                                    self.endTimeText3 = "\(endTime3.year)-\(endTime3.month)-\(endTime3.day)"
                                }, content: {
                                    endTimePicker3
                                })
                            Button(action : {
                                getData(index: 3, startTime: startTimeText3, endTime: endTimeText3)
                            }){
                                Text("查询").font(.headline).foregroundColor(.white)
                            }.background(Rectangle().fill(Color.blue))
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
                            TextField("起始时间", text: $startTimeText4).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker4.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker4,onDismiss:{
                                    self.startTimeText4 = "\(startTime4.year)-\(startTime4.month)-\(startTime4.day)"
                                }, content: {
                                    startTimePicker4
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText4).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker4.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker4,onDismiss:{
                                    self.endTimeText4 = "\(endTime4.year)-\(endTime4.month)-\(endTime4.day)"
                                }, content: {
                                    endTimePicker4
                                })
                            Button(action : {
                                getData(index: 4, startTime: startTimeText4, endTime: endTimeText4)
                            }){
                                Text("查询").font(.headline).foregroundColor(.white)
                            }.background(Rectangle().fill(Color.blue))
                        }
                        AlarmTable(data: $pileData)
                            .frame(minHeight : 200,maxHeight: 250)
                    }
                    Color.gray.frame(height : 2)
                    //用户信息
                    VStack {
                        HStack(spacing : 0) {
                            Text("用户")
                            Spacer()
                            TextField("起始时间", text: $startTimeText5).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker5.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker5,onDismiss:{
                                    self.startTimeText5 = "\(startTime5.year)-\(startTime5.month)-\(startTime5.day)"
                                }, content: {
                                    startTimePicker5
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText5).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker5.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker5,onDismiss:{
                                    self.endTimeText5 = "\(endTime5.year)-\(endTime5.month)-\(endTime5.day)"
                                }, content: {
                                    endTimePicker5
                                })
                            Button(action : {
                                getData(index: 5, startTime: startTimeText5, endTime: endTimeText5)
                            }){
                                Text("查询").font(.headline).foregroundColor(.white)
                            }.background(Rectangle().fill(Color.blue))
                        }
                        AlarmTable(data: $userData)
                            .frame(minHeight : 200,maxHeight: 250)
                    }
                }
            }
        }
    }
    private var startTimePicker1 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime1,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker1 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime1,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var startTimePicker2 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime2,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker2 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime2,displayedComponents:.date)
                .labelsHidden()
        }
    }
    
    private var startTimePicker3 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime3,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker3 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime3,displayedComponents:.date)
                .labelsHidden()
        }
    }
    
    private var startTimePicker4 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime4,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker4 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime4,displayedComponents:.date)
                .labelsHidden()
        }
    }
    
    private var startTimePicker5 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime5,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker5 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime5,displayedComponents:.date)
                .labelsHidden()
        }
    }
    
    private func getData(index : Int,startTime : String,endTime : String){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("http://101.132.236.192:8008/SysManage/Alarm/GetList",
                                 method : .post, parameters: [
                                    "StartDate" : "\(startTime) 00:00:00",
                                    "EndDate" : "\(endTime) 00:00:00",
                                    "page" : "1",
                                    "limit" : "15"
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
                    switch index {
                    case 1:
                        cityData = cityList
                        break
                    case 2:
                        photoData = photoList
                        break
                    case 3:
                        storageData = storageList
                        break
                    case 4:
                        pileData = pileList
                        break
                    case 5:
                        userData = userList
                        break
                    default:
                        return
                    }

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
