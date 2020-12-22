//
//  PhotoPage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/27.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct PhotoPage: View {
    //获取当前的数据库对象，主要是获取当前的cookie
    let dataBase = UserDefaults.standard
    //设备的列表
    @State var devices = [Device]()
    var body: some View {
        ScrollView{
            ForEach(devices){ device in
                DeviceInstruction(device: device)
                Color.black.frame(height : 1)
            }
        }.onAppear{
            //进行网络请求，获取所有设备的信息
            requestForDevices()
        }.navigationBarTitle("光伏逆变器",displayMode: .inline)
    }
    private func requestForDevices(){
        let cookie = dataBase.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(homeBaseUrl)GetDeviceData",method: .post,headers: header)
        request.responseJSON{
            response in
            //处理返回的json信息，放入设备列表里面
            switch response.result{
            
            case .success(_):
                if let data = response.data{
                    do{
                        let json = try JSON(data: data)
                        let deviceArray = json["data"].arrayValue
                        devices.removeAll()
                        for index in 0 ..< deviceArray.count {
                            let deviceInfo = deviceArray[index]
                            devices.append(Device(deviceName: "逆变器\(index + 1)",
                                                  voltaA: "A相：\(deviceInfo["aU"])V",
                                                  voltaB: "B相：\(deviceInfo["bU"])V",
                                                  voltaC: "C相：\(deviceInfo["cU"])V",
                                                  streamA: "A相：\(deviceInfo["aI"])A",
                                                  streamB: "B相：\(deviceInfo["bI"])A",
                                                  streamC: "C相：\(deviceInfo["cI"])A",
                                                  power: "总有功功率：\(deviceInfo["P"])w",
                                                  produceToday: "日发电量：\(deviceInfo["EToday"])kWh",
                                                  producetotally: "总发电量：\(deviceInfo["EMonth"])kWh",
                                                  operatingHours: "工作状态：正在运行 运行时间：：\(deviceInfo["time"])h"))
                        }
                    }catch{
                        debugPrint("设备界面解析json发生错误")
                    }
                }
            case .failure(_):
                debugPrint("设备界面网络请求失败")
            }
        }
    }
}

struct PhotoPage_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPage()
    }
}

struct Device : Identifiable{
    var id = UUID()
    let deviceName : String
    let voltaA : String
    let voltaB : String
    let voltaC : String
    let streamA : String
    let streamB : String
    let streamC : String
    let power : String
    let produceToday : String
    let producetotally : String
    let operatingHours : String
}
