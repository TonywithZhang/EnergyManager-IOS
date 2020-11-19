//
//  PieCharts.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/29.
//  Copyright © 2020 张庆德. All rights reserved.
//

import Foundation
import  UIKit
import SwiftUI
import Charts

struct PieCharts : UIViewRepresentable {
    @Binding var data : PieChartData
    let description : String
    
    func makeUIView(context: Context) -> PieChartView {

        //处理数据
        let pieChart = PieChartView()
        pieChart.data = data
        //处理样式
        let legend = pieChart.legend
        legend.enabled = true
        legend.verticalAlignment = .bottom
        legend.horizontalAlignment = .right
        legend.textColor = UIColor(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0, alpha: 1)
        
        let desc = Description()
        desc.textColor = UIColor(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0, alpha: 1)
        desc.text = description
        pieChart.chartDescription = desc
        pieChart.drawEntryLabelsEnabled = false
        
        return pieChart
    }
    func updateUIView(_ uiView: PieChartView, context: Context) {
        debugPrint("Piechart刷新界面")
        uiView.data = data
        uiView.notifyDataSetChanged()
    }
}
