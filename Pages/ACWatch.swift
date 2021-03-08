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
                            Image("ic_tower")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }.frame(width : size.width * 0.15)
                        //A段母线界面
                        VStack(alignment : .leading) {
                            Text("A段母线").frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerAU)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerAI)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerAP)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerAE)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                        }.frame(width : size.width * 0.35)
                        //B段母线界面
                        VStack(alignment : .leading) {
                            Text("B段母线").frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerBU)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerBI)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerBP)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                            Text(cityPowerBE)
                                .font(.system(size: 12))
                                .frame(maxWidth : .infinity)
                            Spacer()
                        }.frame(width : size.width * 0.35)
                    }.frame(width: size.width, height: 135, alignment: .center)
                    
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
                            
                            Image("ic_photo")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }.frame(width : size.width * 0.15)
                        .padding()
                        //光伏界面具体内容
                        ZStack {
                            VStack(alignment : .leading) {
                                Spacer()
                                Text(photoPower)
                                    .font(.system(size: 12))
                                Spacer()
                                Text(photoTodayEnergy)
                                    .font(.system(size: 12))
                                Spacer()
                                Text(photoTotalEnergy)
                                    .font(.system(size: 12))
                                Spacer()
                                Text(photoTime)
                                    .font(.system(size: 12))
                                Spacer()
                            }.frame(maxWidth : .infinity)
                            HStack{
                                Spacer()
                                VStack{
                                    Spacer()
                                    NavigationLink(
                                        destination: PhotoPage(),
                                        label: {
                                            Text("逆变器")	    
                                        })
                                }
                            }
                        }
                    }.frame(width: size.width, height: 150, alignment: .center)
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
                            Image("ic_storage")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }.frame(width : size.width * 0.20)
                        .padding()
                        //调峰储能界面具体内容
                        VStack(alignment : .leading) {
                            Spacer()
                            Text(storageU)
                                .font(.system(size: 12))
                            Spacer()
                            Text(storageI)
                                .font(.system(size: 12))
                            Spacer()
                            Text(storagePower)
                                .font(.system(size: 12))
                            Spacer()
                            Text(storageState)
                                .font(.system(size: 12))
                            Spacer()
                        }.frame(maxWidth : .infinity)
                    }.frame(width: size.width, height: 135, alignment: .center)
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
                            Spacer()
                            Text("电压：")
                                .font(.system(size: 12))
                            Spacer()
                            Text("电流：")
                                .font(.system(size: 12))
                            Spacer()
                            Text("有功功率：")
                                .font(.system(size: 12))
                            Spacer()
                        }.frame(maxWidth : .infinity)
                    }.frame(width: size.width, height: 135, alignment: .center)
                }.buttonStyle(PlainButtonStyle())
                //分割线
                Text("").frame(width: size.width, height: 2, alignment: .center).background(Color.black)
                //小镇用电界面
                NavigationLink(destination : UserPage()) {
                    HStack(alignment: .top) {
                        //名称和图标
                        VStack {
                            Text("小镇用电")
                            
                            Image("ic_user")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }.frame(width : size.width * 0.20)
                        .padding()
                        //充电桩界面具体内容
                        VStack(alignment : .leading) {
                            Spacer()
                            Text(userP)
                                .font(.system(size: 12))
                            Spacer()
                            Text(userE)
                                .font(.system(size: 12))
                            Spacer()
                        }.frame(maxWidth : .infinity)
                    }.frame(width: size.width, height: 130, alignment: .center)
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
                        self.cityPowerAP = "实时功率：\(json["aP"].doubleValue)kW"
                        self.cityPowerAE = "有功总电能：\(json["aE"].doubleValue)kWh"
                        self.cityPowerBU = "电压：\(json["bV"].doubleValue)V"
                        self.cityPowerBI = "电流：\(String(format: "%.2f", json["bI"].doubleValue * 400))A"
                        self.cityPowerBP = "实时功率：\(json["bP"].doubleValue)kW"
                        self.cityPowerBE = "有功总电能：\(json["bE"].doubleValue)kWh"
                        //更新光伏界面的内容
                        self.photoPower = "实时功率：\(json["totalPower"].doubleValue)kW"
                        self.photoTodayEnergy = "当日累计发电量：\(json["todayEnergy"].doubleValue)kWh"
                        self.photoTotalEnergy = "历史累计发电量：\(json["totalEnergy"].doubleValue)kWh"
                        self.photoTime = "累计发电小时数：\(json["totalTime"].doubleValue)h"
                        //更新调峰储能界面的内容
                        self.storageU = "电压：\(json["storageU"].doubleValue)V"
                        self.storageI = "电流：\(json["storageI"].doubleValue)A"
                        self.storagePower = "有功功率：\(String(format: "%.2f", json["storageP"].doubleValue))kW"
                        self.storageState = json["storageP"].doubleValue > 0 ? "充放电状态：充电" : "充放电状态：放电"
                        //更新小镇用户界面的内容
                        self.userP = "总功率：\(json["userP"].doubleValue)kW"
                        self.userE = "总电量：\(json["userE"].doubleValue)kWh"
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
