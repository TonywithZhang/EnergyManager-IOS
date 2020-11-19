//
//  CityPowerPage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/27.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct CityPowerPage: View {
    @State var peakDayA = "峰时段电量:"
    @State var normalDayA = "平时段电量："
    @State var valleyDayA = "谷时段电量："
    @State var peakDayB = "峰时段电量:"
    @State var normalDayB = "平时段电量："
    @State var valleyDayB = "谷时段电量："
    @State var peakMonthA = "峰时段电量:"
    @State var normalMonthA = "平时段电量："
    @State var valleyMonthA = "谷时段电量："
    @State var peakMonthB = "峰时段电量:"
    @State var normalMonthB = "平时段电量："
    @State var valleyMonthB = "谷时段电量："
    
    //获取当前的数据库对象
    private let dataBase = UserDefaults.standard
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                Text("市电").font(.title).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 50, maxWidth: size.width * 0.15, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                VStack {
                    Text("今日峰平谷用电量")
                    HStack{
                        VStack(alignment : .leading){
                            Spacer()
                            Text("A段母线")
                                .background(Color(red:  0x7e/256.0, green: 0x98/256.0, blue: 0xd2/256.0,opacity: 1.0))
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: .infinity, alignment: .top)
                            Spacer()
                            Text(peakDayA)
                            Spacer()
                            Text(normalDayA)
                            Spacer()
                            Text(valleyDayA)
                            Spacer()
                        }.frame(width: size.width * 0.38, height: .infinity)
                        VStack(alignment : .leading){
                            Spacer()
                            Text("B段母线")
                                .background(Color(red:  0x7e/256.0, green: 0x98/256.0, blue: 0xd2/256.0,opacity: 1.0))
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: .infinity, alignment: .top)
                            Spacer()
                            Text(peakDayB)
                            Spacer()
                            Text(normalDayB)
                            Spacer()
                            Text(valleyDayB)
                            Spacer()
                        }.frame(width: size.width * 0.38, height: .infinity)
                    }
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
            }.frame(width: size.width, height: 210)
            Color.black.frame(height : 2)
            HStack(alignment: .top) {
                Text("市电").font(.title).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 50, maxWidth: size.width * 0.15, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
                VStack {
                    Text("本月峰平谷用电量")
                    HStack{
                        VStack(alignment : .leading){
                            Spacer()
                            Text("A段母线")
                                .background(Color(red:  0x7e/256.0, green: 0x98/256.0, blue: 0xd2/256.0,opacity: 1.0))
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: .infinity, alignment: .top)
                            Spacer()
                            Text(peakMonthA)
                            Spacer()
                            Text(normalMonthA)
                            Spacer()
                            Text(valleyMonthA)
                            Spacer()
                        }.frame(width: size.width * 0.38, height: .infinity)
                        VStack(alignment : .leading){
                            Spacer()
                            Text("B段母线")
                                .background(Color(red:  0x7e/256.0, green: 0x98/256.0, blue: 0xd2/256.0,opacity: 1.0))
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 100, maxWidth: .infinity, alignment: .top)
                            Spacer()
                            Text(peakMonthB)
                            Spacer()
                            Text(normalMonthB)
                            Spacer()
                            Text(valleyMonthB)
                            Spacer()
                        }.frame(width: size.width * 0.38, height: .infinity	)
                    }
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: .top)
            }.frame(width: size.width, height: 210)
            Spacer()
        }.onAppear{
            let cookie = dataBase.string(forKey: "Cookie")!
            var header = HTTPHeaders()
            header.add(name: "Cookie", value: cookie)
            let request = AF.request(homeBaseUrl + "GetCityPowerPageData",method: .post,headers: header)
            request.responseJSON{
                response in
                switch response.result{
                case .success(_):
                    if let data = response.data{
                        do{
                            let json = try JSON(data: data)
                            peakDayA = "峰时段电量：\(json["aFengDay"].doubleValue)kwh"
                            normalDayA = "平时段电量：\(json["aPingDay"].doubleValue)kwh"
                            valleyDayA = "谷时段电量：\(json["aGuDay"].doubleValue)kwh"
                            peakDayB = "峰时段电量：\(json["bFengDay"].doubleValue)kwh"
                            normalDayB = "平时段电量：\(json["bPingDay"].doubleValue)kwh"
                            valleyDayB = "谷时段电量：\(json["bGuDay"].doubleValue)kwh"
                            peakMonthA = "峰时段电量：\(json["aFengMonth"].doubleValue)kwh"
                            normalMonthA = "平时段电量：\(json["aPingMonth"].doubleValue)kwh"
                            valleyMonthA = "谷时段电量：\(json["aGuMonth"].doubleValue)kwh"
                            peakMonthB = "峰时段电量：\(json["bFengMonth"].doubleValue)kwh"
                            normalMonthB = "平时段电量：\(json["bPingMonth"].doubleValue)kwh"
                            valleyMonthB = "谷时段电量：\(json["bGuMonth"].doubleValue)kwh"
                        }catch{
                            debugPrint("转换json数据发生错误")
                        }
                    }
                case .failure(_):
                    debugPrint("市电信息请求失败")
                }
            }
        }.navigationBarTitle("市电",displayMode: .inline)
    }
}

struct CityPowerPage_Previews: PreviewProvider {
    static var previews: some View {
        CityPowerPage()
    }
}
