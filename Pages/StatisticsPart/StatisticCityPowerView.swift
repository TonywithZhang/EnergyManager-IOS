//
//  StatisticView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts

struct StatisticCityPowerView: View {
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showCityPicker = false
    @State private var cityPowerText = ""
    @Binding var chartData1 : LineChartData
    @Binding var chartX1 : [String]
    @Binding var chartData2 : LineChartData
    @Binding var chartX2 : [String]
    var body: some View {
        VStack {
            HStack(spacing : 0) {
                Text("市电")
                Spacer()
                TextField("年/季/月/日", text: $cityPowerText).frame(width : 100)
                    .background(Rectangle().stroke(Color.blue))
                    .font(.subheadline)
                    .onTapGesture(count: 1, perform: {
                        self.showCityPicker.toggle()
                    })
                Button(action : {
                    
                }){
                    Text("查询").font(.headline).foregroundColor(.white)
                }.background(Rectangle().fill(Color.blue))
            }
            HStack{
                NavigationLink(
                    destination: ACSTatisticOne(data: chartData1, xData: chartX1, description: "A段母线功率曲线")
                ){
                    ZStack {
                        LineCharts(lineData: $chartData1, xData: $chartX1, description: "A段母线功率曲线")
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
                }
                NavigationLink(destination : ACSTatisticOne(data: chartData2, xData: chartX2, description: "A段母线功率曲线")){
                    ZStack {
                        LineCharts(lineData: $chartData2, xData: $chartX2, description: "A段母线功率曲线")
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
                }
                
            }
        }.frame(height : 210)
        .sheet(isPresented: $showCityPicker,onDismiss:{
            if !dateList.days.isEmpty{
                cityPowerText = dateList.days
            }else if !dateList.months.isEmpty{
                cityPowerText = dateList.months
            }else{
                cityPowerText = dateList.years
            }
        }, content: {
            DatesPickerView(dateList: dateList)
        })
    }
}
