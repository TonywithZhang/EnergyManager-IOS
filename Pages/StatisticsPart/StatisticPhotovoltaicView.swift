//
//  StatisticPhotovoltaicView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts
import SwiftyJSON
import Alamofire

struct StatisticPhotovoltaicView: View {
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showPhotoPicker = false
    @State private var photoDateText = ""
    @Binding var chartData3 : BarChartData
    @Binding var chartX3 : [String]
    @Binding var chartData4 : BarChartData
    @Binding var chartX4 : [String]
    
    @State private var index = 0
    
    var body: some View {
        VStack {
            HStack(spacing : 0) {
                Text("光伏")
                Spacer()
                TextField("年/季/月/日", text: $photoDateText).frame(width : 100)
                    .background(Rectangle().stroke(Color.blue))
                    .font(.subheadline)
                    .onTapGesture(count: 1, perform: {
                        self.showPhotoPicker.toggle()
                    })
                Button(action : {
                    refreshChart()
                }){
                    Text("查询").font(.headline).foregroundColor(.white)
                }.background(Rectangle().fill(Color.blue))
            }
            HStack{
                NavigationLink(
                    destination: ACStatisticTwo(barData: chartData3, xData: chartX3, description: "光伏发电量"),
                    label: {
                        ZStack {
                            BarCharts(barData: $chartData3, xData: $chartX3, description: "光伏发电量")
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
                    destination: ACStatisticTwo(barData: chartData4, xData: chartX4, description: "光伏发电小时数"),
                    label: {
                        ZStack {
                            BarCharts(barData: $chartData4, xData: $chartX4, description: "光伏发电小时数")
                            HStack {
                                VStack {
                                    Text("单位：h")
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
        .sheet(isPresented: $showPhotoPicker,onDismiss:{
            if !dateList.days.isEmpty{
                self.photoDateText = dateList.days
            }
            else if !dateList.months.isEmpty{
                self.photoDateText = dateList.months
            }else{
                self.photoDateText = dateList.years
            }
        }, content: {
            DatesPickerView(dateList: dateList, showUserSelection: false,selectedIndex: $index)
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
                guard let model = try? JSONDecoder().decode(StatisticPhotovoltaicModel.self, from: data) else {
                    return
                }
                chartX3 = model.time
                chartData3 = ChartDataRepository.getBarChartData(lable: ["光伏发电量"], ys: model.data?.data.map{
                    Double($0)
                } ?? [0.0])
                
            case .failure(_):
                debugPrint("统计分析-交流光伏界面网络请求失败")
            }
        }
    }
    private func getURL() -> String{
        if !dateList.days.isEmpty{
            return "getPhotovaiticDayData"
        }else if !dateList.months.isEmpty{
            return "getPhotovaiticMonthData"
        }else{
            return "getPhotovaiticYearData"
        }
    }
}
