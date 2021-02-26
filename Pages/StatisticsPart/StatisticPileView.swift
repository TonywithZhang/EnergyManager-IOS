//
//  StatisticPileView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI
import Charts

struct StatisticPileView: View {
    @EnvironmentObject var dateList : MultiDate
    
    @State private var showPilePicker = false
    @State private var pileDateText = ""
    @Binding var chartData7 : PieChartData
    
    var body: some View {
        VStack {
            HStack(spacing : 0) {
                Text("充电桩")
                Spacer()
                TextField("年/季/月/日", text: $pileDateText).frame(width : 100)
                    .background(Rectangle().stroke(Color.blue))
                    .font(.subheadline)
                    .onTapGesture(count: 1, perform: {
                        self.showPilePicker.toggle()
                    })
                Button(action : {
                    
                }){
                    Text("查询").font(.headline).foregroundColor(.white)
                }.background(Rectangle().fill(Color.blue))
            }
            
            PieCharts(data: $chartData7, description: "充电功率")
        }.frame(height : 210)
        .sheet(isPresented: $showPilePicker,onDismiss:{
            if !dateList.days.isEmpty{
                self.pileDateText = dateList.days
            }
            else if !dateList.months.isEmpty{
                self.pileDateText = dateList.months
            }else{
                self.pileDateText = dateList.years
            }
        }, content: {
            DatesPickerView(dateList: dateList)
        })
    }
}
