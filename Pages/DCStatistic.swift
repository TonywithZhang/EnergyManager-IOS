//
//  DCStatistic.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/3.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON
import SwiftDate
import Charts

struct DCStatistic: View {
    @State private var interfaceDateText = "年/季/月/日"
    @State private var interfaceDate = Date()
    @State private var showInterfacePicker = false
    @State private var photoDateText = "年/季/月/日"
    @State private var photoDate = Date()
    @State private var showPhotoPicker = false
    @State private var storageDateText = "年/季/月/日"
    @State private var storageDate = Date()
    @State private var showStoragePicker = false
    @State private var userDateText = "年/季/月/日"
    @State private var userDate = Date()
    @State private var showUserPicker = false
    
    @State private var chartData1 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX1 = [String]()
    @State private var chartData2 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX2 = [String]()
    @State private var chartData3 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX3 = [String]()
    @State private var chartData4 = BarChartData(dataSet: BarChartDataSet())
    @State private var chartX4 = [String]()
    @State private var chartData5 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX5 = [String]()
    @State private var chartData6 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX6 = [String]()
    @State private var chartData8 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX8 = [String]()
    @State private var chartData9 = LineChartData(dataSet: LineChartDataSet())
    @State private var chartX9 = [String]()
    var body: some View {
        ScrollView {
            VStack {
                //交流接口
                VStack {
                    HStack(spacing : 0) {
                        Text("交流接口")
                        Spacer()
                        TextField("年/季/月/日", text: $interfaceDateText).frame(width : 100)
                            .background(Rectangle().stroke(Color.blue))
                            .font(.subheadline)
                            .onTapGesture(count: 1, perform: {
                                self.showInterfacePicker.toggle()
                            })
                        Button(action : {
                            
                        }){
                            Text("查询").font(.headline).foregroundColor(.white)
                        }.background(Rectangle().fill(Color.blue))
                    }
                    HStack{
                        NavigationLink(
                            destination: ACSTatisticOne(data: chartData1, xData: chartX1, description: "每小时平均功率"),
                            label: {
                                LineCharts(lineData: $chartData1, xData: $chartX1, description: "每小时平均功率")
                            })
                        NavigationLink(
                            destination: ACSTatisticOne(data: chartData2, xData: chartX2, description: "每日电量"),
                            label: {
                                LineCharts(lineData: $chartData2, xData: $chartX2, description: "每日电量")
                            })
                    }
                }.frame(height : 210)
                .sheet(isPresented: $showInterfacePicker,onDismiss:{
                    self.interfaceDateText = "\(interfaceDate.year)-\(interfaceDate.month)-\(interfaceDate.day)"
                }, content: {
                    cityPicker
                })
                Color.gray.frame(height : 2)
                //光伏图表
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
                            destination: ACSTatisticOne(data: chartData3, xData: chartX3, description: "每小时平均功率"),
                            label: {
                                LineCharts(lineData: $chartData3, xData: $chartX3, description: "每小时平均功率")
                            })
//                        NavigationLink(
//                            destination: ACStatisticTwo(barData: chartData4, xData: chartX4, description: "光伏发电小时数"),
//                            label: {
//                                BarCharts(barData: $chartData4, xData: $chartX4, description: "光伏发电小时数")
//                            })
                    }
                }.frame(height : 210)
                .sheet(isPresented: $showPhotoPicker,onDismiss:{
                    self.photoDateText = "\(photoDate.year)-\(photoDate.month)-\(photoDate.day)"
                }, content: {
                    cityPicker
                })
                Color.gray.frame(height : 2)
                //储能的图表
                VStack {
                    HStack(spacing : 0) {
                        Text("储能")
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
                                LineCharts(lineData: $chartData5, xData: $chartX5, description: "储能充放电量")
                            })
//                        NavigationLink(
//                            destination: ACSTatisticOne(data: chartData6, xData: chartX6, description: "SOC"),
//                            label: {
//                                LineCharts(lineData: $chartData6, xData: $chartX6, description: "SOC")
//                            })
//
                    }
                }.frame(height : 210)
                .sheet(isPresented: $showStoragePicker,onDismiss:{
                    self.storageDateText = "\(storageDate.year)-\(storageDate.month)-\(storageDate.day)"
                }, content: {
                    cityPicker
                })
                Color.gray.frame(height : 2)
                //用户的图表
                VStack {
                    HStack(spacing : 0) {
                        Text("用户")
                        Spacer()
                        TextField("年/季/月/日", text: $userDateText).frame(width : 100)
                            .background(Rectangle().stroke(Color.blue))
                            .font(.subheadline)
                            .onTapGesture(count: 1, perform: {
                                self.showUserPicker.toggle()
                            })
                        Button(action : {
                            
                        }){
                            Text("查询").font(.headline).foregroundColor(.white)
                        }.background(Rectangle().fill(Color.blue))
                    }
                    HStack{
                        NavigationLink(
                            destination: ACSTatisticOne(data: chartData8, xData: chartX8, description: "用户用电量"),
                            label: {
                                LineCharts(lineData: $chartData8, xData: $chartX8, description: "用户用电量")
                            })
                        NavigationLink(
                            destination: ACSTatisticOne(data: chartData9, xData: chartX9, description: "用户用电功率"),
                            label: {
                                LineCharts(lineData: $chartData9, xData: $chartX9, description: "用户用电功率")
                            })
                        
                    }
                }.frame(height : 210)
                .sheet(isPresented: $showUserPicker,onDismiss:{
                    self.userDateText = "\(userDate.year)-\(userDate.month)-\(userDate.day)"
                }, content: {
                    cityPicker
                })
            }
            .onAppear{
                getDCStatisticData()
            }
        }
    }
    private var cityPicker : some View{
        Form {
            DatePicker("请选择一个日期", selection: $interfaceDate,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private func getDCStatisticData(){
        //第一个图标
        getData(url: "\(dcStatisticBaseUrl)GetCommunicationInterfacePowerEcharts", completion: {
            data in
            guard let model = try? JSONDecoder().decode(DCStatisticPowerModel.self, from: data) else{
                return
            }
            chartX1 = model.X
            chartData1 = ChartDataRepository.getLineChartData(lable: ["每小时平均功率"], ys: model.Y.map{
                (Double($0) ?? 0.0)
            })
        })
        //第二个图表
        getData(url: "\(dcStatisticBaseUrl)GetEchartsForMonthEp", completion: {
            data in
            guard let model = try? JSONDecoder().decode(DCStatisticEnergyModel.self, from: data) else{
                return
            }
            chartX2 = model.X
            chartData2 = ChartDataRepository.getLineChartData(lable: ["每日电量"], ys: model.Y.map{
                Double($0) ?? 0.0
            })
        })
        //第三个图表
        getData(url: "\(dcStatisticBaseUrl)GetEchartsForDcPhotovoltaicPower", completion: {
            data in
            guard let model = try? JSONDecoder().decode(DCStatisticPhotovoltaicModel.self, from: data) else{
                return
            }
            chartX3 = model.X
            chartData3 = ChartDataRepository.getLineChartData(lable: ["每小时平均功率"], ys: model.Y.map{
                Double($0) ?? 0.0
            })
        })
        //第五个图表
        getData(url: "\(dcStatisticBaseUrl)GetDcEnergyStoragePowerEcharts", completion: {
            data in
            do{
                let json = try JSON(data : data)
                debugPrint(json)
            }catch{
                debugPrint("转换json发生错误")
            }
            guard let model = try? JSONDecoder().decode(DCStatisticStorageModel.self, from: data) else{
                return
            }
            chartX5 = model.X
            chartData5 = ChartDataRepository.getLineChartData(lable: ["储能充放电功率曲线"], ys: model.Y.map{
                Double($0) ?? 0.0
            })
        })
        //第七个图表
        getData(url: "\(dcStatisticBaseUrl)GetDCAmmeterLogTodayEcharts", completion: {
            data in
            guard let model = try? JSONDecoder().decode(DCStatisticUserHourModel.self, from: data) else{
                return
            }
            chartX8 = model.X
            chartData8 = ChartDataRepository.getLineChartData(lable: ["每小时平均功率"], ys: model.Y.map{
                Double($0) ?? 0.0
            })
        })
        //第八个图表
        getData(url: "\(dcStatisticBaseUrl)GetDCAmmeterLogMonthEcharts", completion: {
            data in
            guard let model = try? JSONDecoder().decode(DCStatisticUserMonthModel.self, from: data) else{
                return
            }
            chartX9 = model.X
            chartData9 = ChartDataRepository.getLineChartData(lable: ["每天发电量"], ys: model.Y.map{
                Double($0) ?? 0.0
            })
        })
    }
    private func getData(url : String,completion : @escaping (Data) -> Void){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let params = [
            "Point" : "15"
        ]
        var request : DataRequest
        if url.contains("Storage"){
            request = AF.request(url,
                                     method: .post,
                                     parameters: params,
                                     headers: header)
        }else{
            request = AF.request(url,
                                     method: .post,
                                     headers: header)
        }
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else{
                    return
                }
                
                completion(data)
//                do{
//                    let json = try JSON(data : data)
//
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
//                    for index in 0 ..< firstYData.count {
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
//                    let thirdData = json["X3"].arrayValue
//
//                    for item in 0 ..< thirdData.count {
//                        x3Data.append(thirdData[item].stringValue)
//                    }
//                    var thirdList = [ChartDataEntry]()
//                    let thirdYData = json["Y3"].arrayValue
//                    for index in 0 ..< thirdYData.count {
//                        thirdList.append(ChartDataEntry(x: Double(index), y: Double(thirdYData[index].stringValue)!))
//                    }
//                    let thirdSet = LineChartDataSet(entries: thirdList,label: "光伏发电量")
//                    thirdSet.setColor(UIColor.blue)
//                    thirdSet.valueTextColor = UIColor.blue
//                    thirdSet.circleRadius = 1
//                    thirdSet.circleHoleRadius = 0
//                    chartData3 = LineChartData(dataSet: thirdSet)
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
//                    let fifthSet = LineChartDataSet(entries: fifthList,label: "储能充放电量")
//                    fifthSet.setColor(UIColor.blue)
//                    fifthSet.valueTextColor = UIColor.blue
//                    fifthSet.circleRadius = 1
//                    fifthSet.circleHoleRadius = 0
//                    chartData5 = LineChartData(dataSet: fifthSet)
//                    chartX5 = x5Data
//
//                    //刷新第七个图表
//                    var x8Data = [String]()
//                    let eighthData = json["X7"].arrayValue
//
//                    for item in 0 ..< eighthData.count {
//                        x8Data.append(eighthData[item].stringValue)
//                    }
//                    var eighthList = [ChartDataEntry]()
//                    let eighthYData = json["Y7"].arrayValue
//                    for index in 0 ..< eighthYData.count {
//                        eighthList.append(ChartDataEntry(x: Double(index), y: Double(eighthYData[index].stringValue)!))
//                    }
//                    let eighthSet = LineChartDataSet(entries: eighthList,label: "1号楼")
//                    eighthSet.setColor(UIColor.blue)
//                    eighthSet.valueTextColor = UIColor.blue
//                    eighthSet.circleRadius = 1
//                    eighthSet.circleHoleRadius = 0
//                    chartData8 = LineChartData(dataSet: eighthSet)
//                    chartX8 = x8Data
//                    //更新第八个图表
//                    var x9Data = [String]()
//                    let ninthData = json["X8"].arrayValue
//
//                    for item in 0 ..< ninthData.count {
//                        x9Data.append(ninthData[item].stringValue)
//                    }
//                    var ninthList = [ChartDataEntry]()
//                    let ninthYData = json["Y8"].arrayValue
//                    for index in 0 ..< ninthYData.count {
//                        ninthList.append(ChartDataEntry(x: Double(index), y: Double(ninthYData[index].stringValue)!))
//                    }
//                    let ninthSet = LineChartDataSet(entries: ninthList,label: "用户用电功率")
//                    ninthSet.setColor(UIColor.blue)
//                    ninthSet.valueTextColor = UIColor.blue
//                    ninthSet.circleRadius = 1
//                    ninthSet.circleHoleRadius = 0
//                    chartData9 = LineChartData(dataSet: ninthSet)
//                    chartX9 = x9Data
//                }catch{
//                    debugPrint("json解析失败")
//                }
            case .failure(_):
                debugPrint("网络请求失败")
                return
            }
        }
    }
    private let dcStatisticBaseUrl = "http://101.132.236.192:8008/SIManage/DCSystem/"
}

struct DCStatistic_Previews: PreviewProvider {
    static var previews: some View {
        DCStatistic()
    }
}
