//
//  ChartDataRepository.swift
//  能源管家
//
//  Created by 张庆德 on 2021/3/1.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation
import Charts
import SwiftUI

class ChartDataRepository {
    //返回折线图的数据
    static func getLineChartData(lable : [String],ys : [Double]...) -> LineChartData{
        var dataSets = [LineChartDataSet]()
        let colorRepo = ColorRepositoty()
        for i in 0 ..< ys.count {
            let y = ys[i]
            var firstList = [ChartDataEntry]()
            for index in 0 ..< y.count {
                firstList.append(ChartDataEntry(x: Double(index), y: y[index]))
            }
            let firstSet = LineChartDataSet(entries: firstList,label: lable[i])
            let color = colorRepo.nextColor()
            firstSet.setColor(color)
            firstSet.valueTextColor = color
            firstSet.circleRadius = 1
            firstSet.circleHoleRadius = 0
            dataSets.append(firstSet)
        }
        
        return LineChartData(dataSets: dataSets)
    }
    //返回条形图的数据
    static func getBarChartData(lable : [String],ys : [Double]...) -> BarChartData{
        var dataSets = [BarChartDataSet]()
        let colorRepo = ColorRepositoty()
        for i in 0 ..< ys.count{
            let y = ys[i]
            var thirdList = [BarChartDataEntry]()
            for index in 0 ..< y.count {
                thirdList.append(BarChartDataEntry(x: Double(index), y: y[index]))
            }
            let thirdSet = BarChartDataSet(entries: thirdList,label: lable[i])
            let color = colorRepo.nextColor()
            thirdSet.setColor(color)
            thirdSet.valueTextColor = color
            dataSets.append(thirdSet)
        }
        
        return BarChartData(dataSets: dataSets)
    }
    //返回饼图的数据
    static func getPieChartData(lables : [String],y : [Double]) -> PieChartData{
        var pieData = [PieChartDataEntry]()
        
        for index in 0 ..< y.count {
            pieData.append(PieChartDataEntry(value: y[index], label: lables[index]))
        }
        //初始化颜色
        let firstColors = [
            UIColor.blue,
            UIColor.red,
            UIColor.darkGray,
            UIColor.black,
            UIColor.cyan
        ]
        //将上面产生的数据和颜色额绑定到Piedata上面
        let dataSet = PieChartDataSet(entries: pieData,label: "")
        dataSet.sliceSpace = 3
        dataSet.selectionShift = 10
        dataSet.colors = firstColors
        let firstData = PieChartData(dataSet: dataSet)
        firstData.setDrawValues(true)
        firstData.setValueTextColor(UIColor.black)
        return firstData
    }
}
