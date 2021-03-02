//
//  ACStatistic.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/3.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Charts
import Alamofire
import SwiftyJSON
import SwiftDate

struct ACStatistic: View {
    @State private var chartData1 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX1 = [String]()
    @State private var chartData2 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX2 = [String]()
    @State private var chartData3 = BarChartData(dataSet: BarChartDataSet())
    @State private var chartX3 = [String]()
    @State private var chartData4 = BarChartData(dataSet: BarChartDataSet())
    @State private var chartX4 = [String]()
    @State private var chartData5 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX5 = [String]()
    @State private var chartData6 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX6 = [String]()
    @State private var chartData7 = PieChartData(dataSet: PieChartDataSet())
    @State private var chartData8 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX8 = [String]()
    @State private var chartData9 = BarChartData(dataSet: BarChartDataSet())
    @State private var chartX9 = [String]()
    
    var body: some View {
        ScrollView {
            VStack(spacing : 4) {
                //市电图表
                StatisticCityPowerView(chartData1: $chartData1, chartX1: $chartX1, chartData2: $chartData2, chartX2: $chartX2)
                    .environmentObject(MultiDate())
                Color.gray.frame(height : 2)
                //光伏图表
                StatisticPhotovoltaicView(chartData3: $chartData3, chartX3: $chartX3, chartData4: $chartData4, chartX4: $chartX4)
                    .environmentObject(MultiDate())
                Color.gray.frame(height : 2)
                //调峰储能的图表
                StatisticStorageView(chartData5: $chartData5, chartX5: $chartX5, chartData6: $chartData6, chartX6: $chartX6)
                    .environmentObject(MultiDate())
                Color.gray.frame(height : 2)
                //充电桩的图表
                StatisticPileView(chartData7: $chartData7)
                    .environmentObject(MultiDate())
                Color.gray.frame(height : 2)
                //用户的图表
                StatisticUserView(chartData8: $chartData8, chartX8: $chartX8, chartData9: $chartData9, chartX9: $chartX9)
                    .environmentObject(MultiDate())
            }
            .onAppear{
                getData()
            }
        }
    }

    //网络请求，获取所有的数据
    private func getData(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(homeBaseUrl)GetACStatisticData",
                                 method: .post,
                                 headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else{
                    return
                }
                do{
                    _ = try JSON(data : data)
                    guard let statisticData = try? JSONDecoder().decode(StatisticAlternateModel.self,from : data) else{
                        return
                    }
                    //第一个图表
                    chartX1 = statisticData.X1
                    chartData1 = ChartDataRepository.getLineChartData(lable: ["A段母线功率曲线"], ys: statisticData.Y1.map{
                        val in
                        (Double(val) ?? 0.0)
                    })
                    //第二个图表
                    chartX2 = statisticData.X2
                    chartData2 = ChartDataRepository.getLineChartData(lable: ["B段母线功率曲线"], ys: statisticData.Y2.map{
                        val in
                        (Double(val) ?? 0.0)
                    })
                    //第三个图表
                    chartX3 = statisticData.dateArry3
                    chartData3 = ChartDataRepository.getBarChartData(lable: ["光伏发电量"], ys: statisticData.jiaoliu3.map{
                        (Double($0) ?? 0.0)
                    })
                    //第四个图表
                    chartX4 = statisticData.dateArry4
                    chartData4 = ChartDataRepository.getBarChartData(lable: ["光伏发电小时数"], ys: statisticData.jiaoliu4.map{
                        Double($0) ?? 0.0
                    })
                    //第五个图表
                    chartX5 = statisticData.X5
                    chartData5 = ChartDataRepository.getLineChartData(lable: ["储能充放电功率"], ys: statisticData.Y5)
                    //第六个图表
                    chartX6 = statisticData.X6
                    chartData6 = ChartDataRepository.getLineChartData(lable: ["储能充电电量","储能放电电量"], ys: statisticData.Y6.map{
                        Double($0)
                    },statisticData.Y62.map{
                        Double($0)
                    })
                    //第七个图表
                    var pieChartNames = [String]()
                    for index in 0 ..< 5 {
                        pieChartNames.append("充电桩\(index + 1)")
                    }
                    chartData7 = ChartDataRepository.getPieChartData(lables: pieChartNames, y: statisticData.X7.map{
                        Double($0)
                    })
                    //第八个图表
                    chartX8 = statisticData.X8
                    chartData8 = ChartDataRepository.getLineChartData(lable: ["用户1用电量","用户2用电量"], ys: statisticData.Y8.map{
                        Double($0)
                    },statisticData.Y82.map{
                        Double($0)
                    })
                    //第九个图表
                    chartX9 = statisticData.X9
                    chartData9 = ChartDataRepository.getBarChartData(lable: ["用户用电功率"], ys: statisticData.Y9.map{
                        (Double($0) ?? 0.0)
                    })
//                    let json = try JSON(data : data)
//                    //刷新第一个图表
//                    var x1Data = [String]()
//                    let firstXData = json["X1"].arrayValue
//
//                    for item in 0 ..< firstXData.count {
//                        x1Data.append(firstXData[item].stringValue)
//                    }
//                    var firstList = [ChartDataEntry]()
//                    let firstYData = json["Y1"].arrayValue
//                    for index in 0 ..< firstYData.count {
//                        firstList.append(ChartDataEntry(x: Double(index), y: Double(firstYData[index].stringValue)!))
//                    }
//                    let firstSet = LineChartDataSet(entries: firstList,label: "A段母线功率曲线")
//                    firstSet.setColor(UIColor.blue)
//                    firstSet.valueTextColor = UIColor.blue
//                    firstSet.circleRadius = 1
//                    firstSet.circleHoleRadius = 0
//                    chartData1 = LineChartData(dataSet: firstSet)
//                    chartX1 = x1Data
//                    //刷新第二个图表
//                    var x2Data = [String]()
//                    let secondData = json["X2"].arrayValue
//
//                    for item in 0 ..< secondData.count {
//                        x2Data.append(secondData[item].stringValue)
//                    }
//                    var secondList = [ChartDataEntry]()
//                    let secondYData = json["Y2"].arrayValue
//                    for index in 0 ..< secondYData.count {
//                        secondList.append(ChartDataEntry(x: Double(index), y: Double(secondYData[index].stringValue)!))
//                    }
//                    let secondSet = LineChartDataSet(entries: secondList,label: "B段母线功率曲线")
//                    secondSet.setColor(UIColor.blue)
//                    secondSet.valueTextColor = UIColor.blue
//                    secondSet.circleRadius = 1
//                    secondSet.circleHoleRadius = 0
//                    chartData2 = LineChartData(dataSet: secondSet)
//                    chartX2 = x2Data
//                    //第三个图表
//                    var x3Data = [String]()
//                    let thirdData = json["dateArry3"].arrayValue
//
//                    for item in 0 ..< thirdData.count {
//                        x3Data.append(thirdData[item].stringValue)
//                    }
//                    var thirdList = [BarChartDataEntry]()
//                    let thirdYData = json["jiaoliu3"].arrayValue
//                    for index in 0 ..< thirdYData.count {
//                        thirdList.append(BarChartDataEntry(x: Double(index), y: Double(thirdYData[index].stringValue)!))
//                    }
//                    let thirdSet = BarChartDataSet(entries: thirdList,label: "光伏发电量")
//                    thirdSet.setColor(UIColor.blue)
//                    thirdSet.valueTextColor = UIColor.blue
//
//                    chartData3 = BarChartData(dataSet: thirdSet)
//                    chartX3 = x3Data
//                    //刷新第四个图表
//                    var x4Data = [String]()
//                    let forthData = json["dateArry4"].arrayValue
//
//                    for item in 0 ..< forthData.count {
//                        x4Data.append(forthData[item].stringValue)
//                    }
//                    var forthList = [BarChartDataEntry]()
//                    let forthYData = json["jiaoliu4"].arrayValue
//                    for index in 0 ..< forthYData.count {
//                        forthList.append(BarChartDataEntry(x: Double(index), y: Double(forthYData[index].stringValue)!))
//                    }
//                    let forthSet = BarChartDataSet(entries: forthList,label: "光伏发电小时数")
//                    forthSet.setColor(UIColor.blue)
//                    forthSet.valueTextColor = UIColor.blue
//
//                    chartData4 = BarChartData(dataSet: forthSet)
//                    chartX4 = x4Data
//                    //刷新第五个图表
//                    var x5Data = [String]()
//                    let fifthData = json["X5"].arrayValue
//
//                    for item in 0 ..< fifthData.count {
//                        x5Data.append(fifthData[item].stringValue)
//                    }
//                    var fifthList = [ChartDataEntry]()
//                    let fifthYData = json["Y5"].arrayValue
//                    for index in 0 ..< fifthYData.count {
//                        fifthList.append(ChartDataEntry(x: Double(index), y: Double(fifthYData[index].stringValue)!))
//                    }
//                    let fifthSet = LineChartDataSet(entries: fifthList,label: "储能充放电功率")
//                    fifthSet.setColor(UIColor.blue)
//                    fifthSet.valueTextColor = UIColor.blue
//                    fifthSet.circleRadius = 1
//                    fifthSet.circleHoleRadius = 0
//                    chartData5 = LineChartData(dataSet: fifthSet)
//                    chartX5 = x5Data
//                    //刷新第六个图表
//                    var x6Data = [String]()
//                    let sixthData = json["X6"].arrayValue
//
//                    for item in 0 ..< sixthData.count {
//                        x6Data.append(sixthData[item].stringValue)
//                    }
//                    var sixthList = [ChartDataEntry]()
//                    var sixth2List = [ChartDataEntry]()
//                    let sixthYData = json["Y6"].arrayValue
//                    let sixth2YData = json["Y62"].arrayValue
//                    for index in 0 ..< sixthYData.count {
//                        sixthList.append(ChartDataEntry(x: Double(index), y: Double(sixthYData[index].intValue)))
//                        sixth2List.append(ChartDataEntry(x: Double(index), y: Double(sixth2YData[index].intValue)))
//                    }
//                    let sixthSet = LineChartDataSet(entries: sixthList,label: "储能放电电量")
//                    let sixth2Set = LineChartDataSet(entries: sixth2List,label: "储能放电电量")
//
//                    sixthSet.setColor(UIColor.blue)
//                    sixthSet.valueTextColor = UIColor.blue
//                    sixthSet.circleRadius = 1
//                    sixthSet.circleHoleRadius = 0
//                    sixth2Set.setColor(UIColor.cyan)
//                    sixth2Set.valueTextColor = UIColor.cyan
//                    sixth2Set.circleRadius = 1
//                    sixth2Set.circleHoleRadius = 0
//
//                    chartData6 = LineChartData(dataSets: [sixthSet,sixth2Set])
//                    chartX6 = x6Data
//                    //刷新第七个图表
//                    var pieData = [PieChartDataEntry]()
//                    let pileArray = json["X7"].arrayValue
//                    for index in 0 ..< 5 {
//                        pieData.append(PieChartDataEntry(value: Double(pileArray[index].intValue), label: "充电桩\(index + 1)"))
//                    }
//                    //初始化颜色
//                    let firstColors = [
//                        UIColor.blue,
//                        UIColor.red,
//                        UIColor.darkGray,
//                        UIColor.black,
//                        UIColor.cyan
//                    ]
//                    //将上面产生的数据和颜色额绑定到Piedata上面
//                    let dataSet = PieChartDataSet(entries: pieData,label: "")
//                    dataSet.sliceSpace = 3
//                    dataSet.selectionShift = 10
//                    dataSet.colors = firstColors
//                    let firstData = PieChartData(dataSet: dataSet)
//                    firstData.setDrawValues(true)
//                    firstData.setValueTextColor(UIColor.blue)
//                    chartData7 = firstData
//                    //刷新第八个图表
//                    var x8Data = [String]()
//                    let eighthData = json["X8"].arrayValue
//
//                    for item in 0 ..< eighthData.count {
//                        x8Data.append(eighthData[item].stringValue)
//                    }
//                    var eighthList = [ChartDataEntry]()
//                    let eighthYData = json["Y8"].arrayValue
//                    for index in 0 ..< eighthYData.count {
//                        eighthList.append(ChartDataEntry(x: Double(index), y: Double(eighthYData[index].stringValue)!))
//                    }
//                    let eighthSet = LineChartDataSet(entries: eighthList,label: "用户用电量")
//                    eighthSet.setColor(UIColor.black)
//                    eighthSet.valueTextColor = UIColor.black
//                    eighthSet.circleRadius = 1
//                    eighthSet.circleHoleRadius = 0
//                    chartData8 = LineChartData(dataSet: eighthSet)
//                    chartX8 = x8Data
//                    //更新第九个图表
//                    var x9Data = [String]()
//                    let ninthData = json["X9"].arrayValue
//
//                    for item in 0 ..< ninthData.count {
//                        x9Data.append(ninthData[item].stringValue)
//                    }
//                    var ninthList = [BarChartDataEntry]()
//                    let ninthYData = json["Y9"].arrayValue
//                    for index in 0 ..< ninthYData.count {
//                        ninthList.append(BarChartDataEntry(x: Double(index), y: Double(ninthYData[index].stringValue)!))
//                    }
//                    let ninthSet = BarChartDataSet(entries: ninthList,label: "用户用电功率")
//                    ninthSet.setColor(UIColor.blue)
//                    ninthSet.valueTextColor = UIColor.blue
//
//                    chartData9 = BarChartData(dataSet: ninthSet)
//                    chartX9 = x9Data
                }catch{
                    debugPrint("json解析失败")
                }
            case .failure(_):
                debugPrint("网络请求失败")
            }
        }
    }

}

struct ACStatistic_Previews: PreviewProvider {
    static var previews: some View {
        ACStatistic()
    }
}
