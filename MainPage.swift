//
//  MainPage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/23.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct MainPage: View {
    @State private var watchIndex = 0
    @State private var statisticIndex = 0
    @State private var alarmIndex = 0
    var body: some View {
        TabView{
            VStack{
                SlidingTabView(selection: $watchIndex, tabs: ["交流检测","直流检测"])
                if watchIndex == 0 {
                    ACWatch()
                }else{
                    DCWatch()
                }
                Spacer()
            }.tabItem {
                Image(systemName: "doc.text.below.ecg")
                Text("实时监控")
            }
            
            VStack{
                SlidingTabView(selection: $statisticIndex, tabs: ["交流系统","直流系统"])
                if statisticIndex == 0 {
                    ACStatistic()
                }else{
                    DCStatistic()
                }
                Spacer()
            }.tabItem {
                Image(systemName: "chart.pie")
                Text("统计分析")
            }
            
            VStack{
                SlidingTabView(selection: $alarmIndex, tabs: ["交流系统","直流系统"])
                if alarmIndex == 0 {
                    ACAlarm()
                }else{
                    DCAlarm()
                }
                Spacer()
            }.tabItem {
                Image(systemName: "bell")
                Text("报警管理")
            }
            
            VStack{
                User()
            }.tabItem {
                Image(systemName: "person")
                Text("个人中心")
            }
        }.navigationBarTitle("",displayMode: .inline)
    }
    
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage()
    }
}
