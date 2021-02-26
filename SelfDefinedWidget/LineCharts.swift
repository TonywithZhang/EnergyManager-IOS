//
//  LineCharts.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/30.
//  Copyright © 2020 张庆德. All rights reserved.
//

import Foundation
import SwiftUI
import Charts

struct LineCharts : UIViewRepresentable {
    @Binding var lineData : LineChartData
    @Binding var xData : [String]
    let description : String
    func makeUIView(context: Context) -> LineChartView {
        let view = LineChartView()
        //初始化view的各种参数 x轴 y轴 样式等等
        
        //初始化legend
        let legend = view.legend
        legend.enabled = true
        legend.verticalAlignment = .top
        legend.horizontalAlignment = .right
        legend.textColor = .black
        //初始化x轴
        let x = view.xAxis
        x.valueFormatter = IndexAxisValueFormatter(values: xData)
        x.labelRotationAngle = -25
        x.labelCount = 5
        x.labelPosition = .bottom
        x.labelTextColor = .black
        //初始化y轴，关闭右边轴
        view.leftAxis.labelTextColor = .black
        
        view.rightAxis.enabled = false
        //初始化描述信息
        let desc = Description()
        desc.textColor = .black
        desc.text = description
        view.chartDescription = desc
        view.data = lineData
        return view
    }
    
    func updateUIView(_ uiView: LineChartView, context: Context) {
        uiView.data = lineData
        uiView.xAxis.valueFormatter = IndexAxisValueFormatter(values: xData)
        uiView.notifyDataSetChanged()
    }
    
typealias UIViewType = LineChartView
}
