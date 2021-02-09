//
//  ACSTatisticOne.swift
//  能源管家
//
//  Created by 张庆德 on 2020/12/22.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Charts

struct ACSTatisticOne: View {
    @State var data : LineChartData
    @State var xData : [String]
    let description : String
    var body: some View {
        LineCharts(lineData: $data, xData: $xData, description: description)
            .frame(width: size.height - 25, height: size.width - 10, alignment: .center)
            .rotationEffect(.degrees(90))
    }
}

