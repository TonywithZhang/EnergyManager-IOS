//
//  DCWatch.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/23.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Charts
import Alamofire
import SwiftyJSON

struct DCWatch: View {
    
    //界面中所有需要更新的数据
    @State private var acU = "电压："
    @State private var acI = "电流："
    @State private var acP = "功率："
    @State private var acE = "电量："
    
    @State private var photoP = "实时功率："
    @State private var photoTodayE = "当日累计发电量："
    @State private var photoTotalE = "历史累计发电量："
    @State private var photoTime = "累计发电小时数："
    
    @State private var storageU = "电压："
    @State private var storageI = "电流："
    @State private var storageP = "功率："
    
    @State private var userU = "电压："
    @State private var userI = "电流："
    @State private var userP = "功率："
    @State private var userE = "电量："
    var body: some View {
        ScrollView {
            VStack {
                //交流接口
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("交流接口")
                        Spacer()
                        Image(systemName: "personalhotspot")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(red: 0x99 / 255.0, green: 0xc8 / 255.0, blue: 0x7a / 255.0))
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Text("").frame(maxWidth : .infinity)
                        Spacer()
                        Text(acU)
                        Spacer()
                        Text(acI)
                        Spacer()
                        Text(acP)
                        Spacer()
                        Text(acE)
                        Spacer()
                    }.frame(width : size.width * 0.75)
                }.frame(width: size.width, height: 180, alignment: .center)
                //直流光伏
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("直流光伏")
                        Spacer()
                        Image("photo_dc")
                            .resizable()
                            .scaledToFit()
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Text("").frame(maxWidth : .infinity)
                        Spacer()
                        Text(photoP)
                        Spacer()
                        Text(photoTodayE)
                        Spacer()
                        Text(photoTotalE)
                        Spacer()
                        Text(photoTime)
                        Spacer()
                    }.frame(width : size.width * 0.75)
                }.frame(width: size.width, height: 180, alignment: .center)
                //储能
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("储能")
                        Spacer()
                        Image(systemName: "bolt.fill.batteryblock")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(red: 0x99 / 255.0, green: 0xc8 / 255.0, blue: 0x7a / 255.0))
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Text("").frame(maxWidth : .infinity)
                        Group{
                            Spacer()
                            Text(storageU)
                        }
                        Group{
                            Spacer()
                            Text(storageI)
                        }
                        Group{
                            Spacer()
                            Text(storageP)
                        }
                        Group{
                            Spacer()
                            Text("电量：")
                        }
                        Spacer()
                        Group{
                            Text("soc：")
                            Spacer()
                        }
                    }.frame(width : size.width * 0.75)
                }.frame(width: size.width, height: 180, alignment: .center)
                //用户
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("用户")
                        Spacer()
                        Image(systemName: "person.3")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(red: 0x99 / 255.0, green: 0xc8 / 255.0, blue: 0x7a / 255.0))
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Text("").frame(maxWidth : .infinity)
                        Group{
                            Spacer()
                            Text(userU)
                        }
                        Group{
                            Spacer()
                            Text(userI)
                        }
                        Group{
                            Spacer()
                            Text(userP)
                        }
                        Group{
                            Spacer()
                            Text(userE)
                        }
                        Spacer()
                        
                    }.frame(width : size.width * 0.75)
                }.frame(width: size.width, height: 180, alignment: .center)
            }
            .onAppear{
                getData()
            }
        }.frame(width : size.width)
    }
    private func getData(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(homeBaseUrl)GetDCPageData",method: .post,headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else{
                    return
                }
                do{
                    let json = try JSON(data : data)
                    acU = "电压：\(formatFloat(d: json["acU"].doubleValue))V"
                    acI = "电流：\(formatFloat(d: json["acI"].doubleValue))A"
                    acP = "功率：\(formatFloat(d: json["acP"].doubleValue))kw"
                    acE = "电量：\(formatFloat(d: json["acEp"].doubleValue))kwh"
                    photoP = "实时功率：\(json["photoP"].doubleValue)kw"
                    photoTodayE = "当日累计发电量：\(formatFloat(d: json["todayEp"].doubleValue))kwh"
                    photoTotalE = "历史累计发电量：\(formatFloat(d: json["photoEp"].doubleValue))kwh"
                    photoTime = "累计发电小时数：\(json["RunTime"].intValue)h"
                    storageU = "电压：\(json["storeU"].doubleValue)V"
                    storageI = "电流：\(json["storeI"].doubleValue)A"
                    storageP = "功率：\(json["storeP"].doubleValue)kw"
                    userU = "电压：\(json["userU"].doubleValue)V"
                    userI = "电流：\(json["userI"].doubleValue)A"
                    userP = "功率：\(json["userP"].doubleValue)kw"
                    userE = "电量：\(formatFloat(d: json["photoEp"].doubleValue))kwh"
                }catch{
                    debugPrint("解析json数据发生错误")
                }
            case .failure(_):
                debugPrint("DCWatch界面网络请求失败")
            }
        }
    }
    private func formatFloat(d : Double) -> String{
        return String(format: "%.2f", d)
    }
}

struct DCWatch_Previews: PreviewProvider {
    static var previews: some View {
        DCWatch()
    }
}
