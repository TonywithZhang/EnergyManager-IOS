//
//  StatisticPhotovoltaicView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts

struct StatisticPhotovoltaicView: View {
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showPhotoPicker = false
    @State private var photoDateText = ""
    @Binding var chartData3 : BarChartData
    @Binding var chartX3 : [String]
    @Binding var chartData4 : BarChartData
    @Binding var chartX4 : [String]
    
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
            DatesPickerView(dateList: dateList)
        })
    }
}
