//
//  StoragePage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/28.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Alamofire

struct StoragePage: View {
    @State var dayP = "峰时段电量："
    @State var dayN = "平时段电量："
    @State var dayV = "谷时段电量："
    @State var monthP = "峰时段电量："
    @State var monthN = "平时段电量："
    @State var monthV = "谷时段电量："
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("调峰储能")
                    Spacer()
                }.frame(width: 100, height: .infinity, alignment: .center)
                Divider()
                VStack{
                    Text("今日充放电电量")
                    Spacer()
                    Text(dayP)
                    Spacer()
                    Text(dayN)
                    Spacer()
                    Text(dayV)
                    Spacer()
                }.frame(width: .infinity, height: .infinity, alignment: .center)
            }.frame(width: size.width, height: 200, alignment: .leading)
            Divider()
            HStack {
                VStack {
                    Text("调峰储能")
                    Spacer()
                }.frame(width: 100, height: .infinity, alignment: .center)
                Divider()
                VStack{
                    Text("累计充放电电量")
                    Spacer()
                    Text(monthP)
                    Spacer()
                    Text(monthN)
                    Spacer()
                    Text(monthV)
                    Spacer()
                }.frame(width: .infinity, height: .infinity, alignment: .center)
            }.frame(width: size.width, height: 200, alignment: .leading)
            Spacer()
        }.navigationBarTitle("调峰储能",displayMode: .inline)
        .onAppear{
            getStorageData()
        }
    }
    private func getStorageData(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(storageBaseUrl)GetLoadEnergyStorageTotalData",
                                 method: .post,
                                 headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.data{
                    do{
                        let json = try JSON(data : data)
                        dayP = "峰时段电量：\(json["PeakDayBattery"].doubleValue)kwh"
                        dayN = "平时段电量：\(json["OrdinaryDayBattery"].doubleValue)kwh"
                        dayV = "谷时段电量：\(json["ValleyDayBattery"].doubleValue)kwh"
                        monthP = "峰时段电量：\(json["PeakDayTotalBattery"].doubleValue)kwh"
                        monthN = "平时段电量：\(json["OrdinaryDayTotalBattery"].doubleValue)kwh"
                        monthV = "谷时段电量：\(json["ValleyDayTotalBattery"].doubleValue)kwh"
                    }catch{
                        debugPrint("调峰储能界面转换json数据发生错误")
                    }
                }
            case .failure(_):
                debugPrint("调峰储能界面的网络请求失败")
            }
        }
    }
}

struct StoragePage_Previews: PreviewProvider {
    static var previews: some View {
        StoragePage()
    }
}
