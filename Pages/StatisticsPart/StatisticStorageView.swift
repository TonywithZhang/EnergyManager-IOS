//
//  StatisticStorageView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts

struct StatisticStorageView: View {
    
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showStoragePicker = false
    @State private var storageDateText = ""
    @Binding var chartData5 : LineChartData
    @Binding var chartX5 : [String]
    @Binding var chartData6 : LineChartData
    @Binding var chartX6 : [String]
    
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
            DatesPickerView(dateList: dateList)
        })
    }
}
