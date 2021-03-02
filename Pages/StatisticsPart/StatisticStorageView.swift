//
//  StatisticStorageView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts
import Alamofire

struct StatisticStorageView: View {
    
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showStoragePicker = false
    @State private var storageDateText = ""
    @Binding var chartData5 : LineChartData
    @Binding var chartX5 : [String]
    @Binding var chartData6 : LineChartData
    @Binding var chartX6 : [String]
    
    @State private var index = 0
    var body: some View {
        VStack {
            HStack(spacing : 0) {
                Text("调峰储能")
                Spacer()
                TextField("年/季/月/日", text: $storageDateText).frame(width : 100)
                    .background(Rectangle().stroke(Color.blue))
                    .font(.subheadline)
                    .onTapGesture(count: 1, perform: {
                        self.showStoragePicker.toggle()
                    })
                Button(action : {
                    refreshChart()
                }){
                    Text("查询").font(.headline).foregroundColor(.white)
                }.background(Rectangle().fill(Color.blue))
            }
            HStack{
                NavigationLink(
                    destination: ACSTatisticOne(data: chartData5, xData: chartX5, description: "储能充放电量"),
                    label: {
                        ZStack {
                            LineCharts(lineData: $chartData5, xData: $chartX5, description: "储能充放电量")
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
                    destination: ACSTatisticOne(data: chartData6, xData: chartX6, description: "SOC"),
                    label: {
                        ZStack {
                            LineCharts(lineData: $chartData6, xData: $chartX6, description: "SOC")
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
            }
        }.frame(height : 210)
        .sheet(isPresented: $showStoragePicker,onDismiss:{
            if !dateList.days.isEmpty{
                self.storageDateText = dateList.days
            }
            else if !dateList.months.isEmpty{
                self.storageDateText = dateList.months
            }else{
                self.storageDateText = dateList.years
            }
        }, content: {
            DatesPickerView(dateList: dateList,showUserSelection: false,selectedIndex: $index)
        })
    }
    
    private func refreshChart(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let dic = [
            "days" : dateList.days,
            "months" : dateList.months,
            "years" : dateList.years
        ]
        AF.request("http://101.132.236.192:8008/ReportManage/Echarts/\(getURL())",method: .post,parameters: dic,headers: header).responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                guard let model = try? JSONDecoder().decode(StatisticStorageModel.self, from: data) else {
                    return
                }
                chartX5 = model.time
                chartData5 = ChartDataRepository.getLineChartData(lable: ["储能充电量"], ys: model.data[0].data)
                chartX6 = model.time
                chartData6 = ChartDataRepository.getLineChartData(lable: ["储能放电量"], ys: model.data[1].data.map{
                    abs($0)
                })
            case .failure(_):
                debugPrint("统计分析-交流光伏界面网络请求失败")
            }
        }
    }
    private func getURL() -> String{
        if !dateList.days.isEmpty{
            return "getStorageDayData"
        }else if !dateList.months.isEmpty{
            return "getStorageMonthData"
        }else{
            return "getStorageYearData"
        }
    }
}
