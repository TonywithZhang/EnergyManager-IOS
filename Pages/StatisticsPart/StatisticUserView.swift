//
//  StatisticUserView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts
import Alamofire

struct StatisticUserView: View {
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showUserPicker = false
    @State private var userDateText = ""
    @State private var userIndex = 0
    @Binding var chartData8 : LineChartData
    @Binding var chartX8 : [String]
    @Binding var chartData9 : BarChartData
    @Binding var chartX9 : [String]
    var body: some View {
        VStack {
            HStack(spacing : 0) {
                Text("用户")
                Spacer()
                TextField("年/季/月/日", text: $userDateText).frame(width : 100)
                    .background(Rectangle().stroke(Color.blue))
                    .font(.subheadline)
                    .onTapGesture(count: 1, perform: {
                        self.showUserPicker.toggle()
                    })
                Button(action : {
                    refreshChart()
                }){
                    Text("查询").font(.headline).foregroundColor(.white)
                }.background(Rectangle().fill(Color.blue))
            }
            HStack{
                NavigationLink(
                    destination: ACSTatisticOne(data: chartData8, xData: chartX8, description: "用户用电量"),
                    label: {
                        ZStack {
                            LineCharts(lineData: $chartData8, xData: $chartX8, description: "用户用电量")
                            HStack {
                                VStack {
                                    Text("单位：kWh")
                                        .font(.system(size : 12))
                                        .fontWeight(.light)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    })
                NavigationLink(
                    destination: ACStatisticTwo(barData: chartData9, xData: chartX9, description: "用户用电功率"),
                    label: {
                        ZStack {
                            BarCharts(barData: $chartData9, xData: $chartX9, description: "用户用电功率")
                            HStack {
                                VStack {
                                    Text("单位：kW")
                                        .font(.system(size : 12))
                                        .fontWeight(.light)
                                        .foregroundColor(Color.black)
                                    Spacer()
                                }
                                Spacer()
                            }
                        }
                    })
            }
        }.frame(height : 210)
        .sheet(isPresented: $showUserPicker,onDismiss:{
            if !dateList.days.isEmpty{
                self.userDateText = dateList.days
            }
            else if !dateList.months.isEmpty{
                self.userDateText = dateList.months
            }else{
                self.userDateText = dateList.years
            }
        }, content: {
            DatesPickerView(dateList: dateList,showUserSelection: true, selectedIndex: $userIndex)
        })
    }
    private func refreshChart(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let dic = [
            "days" : dateList.days,
            "months" : dateList.months,
            "years" : dateList.years,
            "user" : "\(userIndex + 1)"
        ]
        AF.request("http://101.132.236.192:8008/ReportManage/Echarts/\(getURL())",method: .post,parameters: dic,headers: header).responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                guard let model = try? JSONDecoder().decode(StatisticUserModel.self, from: data) else {
                    return
                }
                chartX8 = model.time
                chartData8 = ChartDataRepository.getLineChartData(lable: ["\(users[userIndex])用电量"], ys: model.data?.data.map{
                    Double($0)
                } ?? [0.0])
                
            case .failure(_):
                debugPrint("统计分析-交流用户界面网络请求失败")
            }
        }
    }
    private func getURL() -> String{
        if !dateList.days.isEmpty{
            return "getUserDayData"
        }else if !dateList.months.isEmpty{
            return "getUserMonthData"
        }else{
            return "getUserYearData"
        }
    }
}
