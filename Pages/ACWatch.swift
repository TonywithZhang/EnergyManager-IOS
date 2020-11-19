//
//  ACWatch.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/23.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct ACWatch: View {
    //下面八个电量是市电里面的内容
    @State var cityPowerAU = "电压："
    @State var cityPowerAI = "电流："
    @State var cityPowerAP = "实时功率："
    @State var cityPowerAE = "有功总电量："
    @State var cityPowerBU = "电压："
    @State var cityPowerBI = "电流："
    @State var cityPowerBP = "实时功率："
    @State var cityPowerBE = "有功总电量："
    //下面四个变量是光伏界面的内容
    @State var photoPower = "实时功率："
    @State var photoTodayEnergy = "当日累计发电量："
    @State var photoTotalEnergy = "历史累计发电量："
    @State var photoTime = "累计发电小时数："
    //下面四个是调峰储能界面的内容
    @State var storageU = "电压："
    @State var storageI = "电流："
    @State var storagePower = "有功功率："
    @State var storageState = "充放电状态："
    //下面两个是小镇用电界面的内容
    @State var userP = "总功率："
    @State var userE = "总电量："
    
    //保存一些数据
    private let dataBase = UserDefaults.standard
    var body: some View {
        NavigationView {
            ScrollView {
                //市电界面
                NavigationLink(destination:CityPowerPage()) {
                    HStack(alignment: .top) {
                        //名称和图标
                        VStack {
                            Text("市电")
                            Spacer()
                            Image("ic_tower")
                                .resizable()
                                .scaledToFit()
                        }.frame(width : size.width * 0.15)
                        .padding()
                        //A段母线界面
                        VStack(alignment : .leading) {
                            Text("A段母线").frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerAU)
                            Spacer()
                            Text(cityPowerAI)
                            Spacer()
                            Text(cityPowerAP)
                            Spacer()
                            Text(cityPowerAE)
                            Spacer()
                        }.frame(width : size.width * 0.35)
                        //B段母线界面
                        VStack(alignment : .leading) {
                            Text("B段母线").frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerBU)
                            Spacer()
                            Text(cityPowerBI)
                            Spacer()
                            Text(cityPowerBP)
                            Spacer()
                            Text(cityPowerBE)
                            Spacer()
                        }.frame(width : size.width * 0.35)
                    }.frame(width: size.width, height: 210, alignment: .center)
                    
                }
                .navigationBarHidden(true)
                .buttonStyle(PlainButtonStyle())
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //光伏界面
                NavigationLink(destination : PhotoPage()) {
                    HStack(alignment: .top) {
                        //名称和图标
                        VStack {
                            Text("光伏")
                            Spacer()
                            Image("ic_photo")
                                .resizable()
                                .scaledToFit()
                        }.frame(width : size.width * 0.15)
                        .padding()
                        //光伏界面具体内容
                        VStack(alignment : .leading) {
                            Text("").frame(maxWidth : .infinity)
                            Spacer()
                            Text(photoPower)
                            Spacer()
                            Text(photoTodayEnergy)
                            Spacer()
                            Text(photoTotalEnergy)
                            Spacer()
                            Text(photoTime)
                            Spacer()
                        }
                        
                    }.frame(width: size.width, height: 210, alignment: .center)
                }
                .buttonStyle(PlainButtonStyle())
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //调峰储能界面
                NavigationLink(destination : StoragePage()) {
                    HStack(alignment: .top) {
                        //名称和图标
                        VStack {
                            Text("调峰储能")
                            Spacer()
                            Image("ic_storage")
                                .resizable()
                                .scaledToFit()
                        }.frame(width : size.width * 0.15)
                        .padding()
                        //调峰储能界面具体内容
                        VStack(alignment : .leading) {
                            Text("").frame(maxWidth : .infinity)
                            Spacer()
                            Text(storageU)
                            Spacer()
                            Text(storageI)
                            Spacer()
                            Text(storagePower)
                            Spacer()
                            Text(storageState)
                            Spacer()
                        }
                    }.frame(width: size.width, height: 210, alignment: .center)
                }.buttonStyle(PlainButtonStyle())
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //充电桩界面
                NavigationLink(destination : PilePage()) {
                    HStack(alignment: .top) {
                        //名称和图标
                        VStack {
                            Text("充电桩")
                            Spacer()
                            Image("ic_pile")
                                .resizable()
                                .scaledToFit()
                        }.frame(width : size.width * 0.15)
                        .padding()
                        //充电桩界面具体内容
                        VStack(alignment : .leading) {
                            Text("").frame(maxWidth : .infinity)
                            Spacer()
                            Text("电压：")
                            Spacer()
                            Text("电流：")
                            Spacer()
                            Text("有功功率：")
                            Spacer()
                            
                        }
                    }.frame(width: size.width, height: 210, alignment: .center)
                }.buttonStyle(PlainButtonStyle())
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //小镇用电界面
                NavigationLink(destination : UserPage()) {
                    HStack(alignment: .top) {
                        //名称和图标
                        VStack {
                            Text("小镇用电")
                            Spacer()
                            Image("ic_user")
                                .resizable()
                                .scaledToFit()
                        }.frame(width : size.width * 0.15)
                        .padding()
                        //充电桩界面具体内容
                        VStack(alignment : .leading) {
                            Text("").frame(maxWidth : .infinity)
                            Spacer()
                            Text(userP)
                            Spacer()
                            Text(userE)
                            Spacer()
                            
                        }
                    }.frame(width: size.width, height: 210, alignment: .center)
                }.buttonStyle(PlainButtonStyle())
            }.frame(width: size.width)
            .onAppear{
                let network = Timer.scheduledTimer(withTimeInterval: 60, repeats: true, block: {
                    _ in
                    refreshUI()
                })
                network.tolerance = 6
                network.fire()
        }
        }
    }
    private func refreshUI(){
        debugPrint("实时监控-交流检测进行一次网络请求")
        let cookie = dataBase.string(forKey: "Cookie")!
        var headers = HTTPHeaders()
        headers.add(name: "Cookie", value: cookie)
        //这一步是请求市电界面的数据
        let request = AF.request("\(homeBaseUrl)GetHomePageData",
                   method: .post,
                   headers: headers)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.data{
                    do{
                        let json = try JSON(data:data)
                        //更新界面所有信息
                        //更新市电界面的内容
                        self.cityPowerAU = "电压：\(json["V"].doubleValue)V"
                        self.cityPowerAI = "电流：\(String(format: "%.2f", json["aI"].doubleValue * 400))A"
                        self.cityPowerAP = "实时功率：\(json["aP"].doubleValue)kw"
                        self.cityPowerAE = "有功总电能：\(json["aE"].doubleValue)kwh"
                        self.cityPowerBU = "电压：\(json["bV"].doubleValue)V"
                        self.cityPowerBI = "电流：\(String(format: "%.2f", json["bI"].doubleValue * 400))A"
                        self.cityPowerBP = "实时功率：\(json["bP"].doubleValue)kw"
                        self.cityPowerBE = "有功总电能：\(json["bE"].doubleValue)kwh"
                        //更新光伏界面的内容
                        self.photoPower = "实时功率：\(json["totalPower"].doubleValue)kw"
                        self.photoTodayEnergy = "当日累计发电量：\(json["todayEnergy"].doubleValue)kwh"
                        self.photoTotalEnergy = "历史累计发电量：\(json["totalEnergy"].doubleValue)kwh"
                        self.photoTime = "累计发电小时数：\(json["totalTime"].doubleValue)h"
                        //更新调峰储能界面的内容
                        self.storageU = "电压：\(json["storageU"].doubleValue)V"
                        self.storageI = "电流：\(json["storageI"].doubleValue)A"
                        self.storagePower = "有功功率：\(String(format: "%.2f", json["storageP"].doubleValue))kw"
                        self.storageState = json["storageP"].doubleValue > 0 ? "充放电状态：充电" : "充放电状态：放电"
                        //更新小镇用户界面的内容
                        self.userP = "总功率：\(json["userP"].doubleValue)kw"
                        self.userE = "总电量：\(json["userE"].doubleValue)kwh"
                    }catch{
                        debugPrint("发生错误")
                    }
                    
                }
            case .failure(_):
                debugPrint("网络请求失败")
            }
        }
        //
    }
}

struct ACWatch_Previews: PreviewProvider {
    static var previews: some View {
        ACWatch()
    }
}
