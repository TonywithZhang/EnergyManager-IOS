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
                            
                        Image(systemName: "personalhotspot")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(red: 0x99 / 255.0, green: 0xc8 / 255.0, blue: 0x7a / 255.0))
                        Spacer()
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Spacer()
                        Text(acU)
                            .font(.system(size: 12))
                        Spacer()
                        Text(acI)
                            .font(.system(size: 12))
                        Spacer()
                        Text(acP)
                            .font(.system(size: 12))
                        Spacer()
                        Text(acE)
                            .font(.system(size: 12))
                        Spacer()
                    }.frame(maxWidth : .infinity)
                }.frame(width: size.width, height: 180, alignment: .center)
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //直流光伏
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("直流光伏")
                        
                        Image("photo_dc")
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Spacer()
                        Text(photoP)
                            .font(.system(size: 12))
                        Spacer()
                        Text(photoTodayE)
                            .font(.system(size: 12))
                        Spacer()
                        Text(photoTotalE)
                            .font(.system(size: 12))
                        Spacer()
                        Text(photoTime)
                            .font(.system(size: 12))
                        Spacer()
                    }.frame(maxWidth : .infinity)
                }.frame(width: size.width, height: 180, alignment: .center)
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //储能
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("储能")
                        
                        Image(systemName: "bolt.fill.batteryblock")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(red: 0x99 / 255.0, green: 0xc8 / 255.0, blue: 0x7a / 255.0))
                        Spacer()
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Group{
                            Spacer()
                            Text(storageU)
                                .font(.system(size: 12))
                        }
                        Group{
                            Spacer()
                            Text(storageI)
                                .font(.system(size: 12))
                        }
                        Group{
                            Spacer()
                            Text(storageP)
                                .font(.system(size: 12))
                        }
                        Group{
                            Spacer()
                            Text("电量：")
                                .font(.system(size: 12))
                        }
                        Spacer()
                        Group{
                            Text("soc：")
                                .font(.system(size: 12))
                            Spacer()
                        }
                    }.frame(maxWidth : .infinity)
                }.frame(width: size.width, height: 200, alignment: .center)
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //用户
                HStack(alignment : .top) {
                    //名称和图标
                    VStack {
                        Text("用户")
                        Image(systemName: "person.3")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color(red: 0x99 / 255.0, green: 0xc8 / 255.0, blue: 0x7a / 255.0))
                        Spacer()
                    }.frame(width : size.width * 0.15)
                    .padding()
                    //具体数据
                    VStack(alignment : .leading) {
                        Group{
                            Spacer()
                            Text(userU)
                                .font(.system(size: 12))
                        }
                        Group{
                            Spacer()
                            Text(userI)
                                .font(.system(size: 12))
                        }
                        Group{
                            Spacer()
                            Text(userP)
                                .font(.system(size: 12))
                        }
                        Group{
                            Spacer()
                            Text(userE)
                                .font(.system(size: 12))
                        }
                        Spacer()
                        
                    }.frame(maxWidth : .infinity)
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
                    acP = "功率：\(formatFloat(d: json["acP"].doubleValue))kW"
                    acE = "电量：\(formatFloat(d: json["acEp"].doubleValue))kWh"
                    photoP = "实时功率：\(json["photoP"].doubleValue * 1000)W"
                    photoTodayE = "当日累计发电量：\(formatFloat(d: json["todayEp"].doubleValue))kWh"
                    photoTotalE = "历史累计发电量：\(formatFloat(d: json["photoEp"].doubleValue))kWh"
                    photoTime = "累计发电小时数：\(json["RunTime"].intValue)h"
                    storageU = "电压：\(json["storeU"].doubleValue)V"
                    storageI = "电流：\(json["storeI"].doubleValue)A"
                    storageP = "功率：\(json["storeP"].doubleValue)kW"
                    userU = "电压：\(json["userU"].doubleValue)V"
                    userI = "电流：\(json["userI"].doubleValue)A"
                    userP = "功率：\(json["userP"].doubleValue)W"
                    userE = "电量：\(formatFloat(d: json["photoEp"].doubleValue))kWh"
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
