//
//  LandScape.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/28.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Charts
import Alamofire
import SwiftyJSON
import SwiftDate

struct LandScape: View {
    //lottie动画是否播放
    @State var lottiePlaying = true
    //天气数据
    @State var picName = "sun.max.fill"
    @State var weather = "晴"
    @State var operatingTime = "已正常运行487天"
    //控制简洁是否打开
    @State var isPresentationOpen = false
    //第一个饼图的数据
    @State var firstPieChartData = PieChartData(dataSet: PieChartDataSet())
    @State var secondPieChartData = PieChartData(dataSet: PieChartDataSet())
    //光伏曲线图的数据
    @State var photoChartData = LineChartData(dataSet: LineChartDataSet())
    @State var photoChartXData = [String]()
    //储能折线图的数据
    @State var storageChartData = LineChartData(dataSet: LineChartDataSet())
    @State var storageChartXData = [String]()
    //节省金额的变量
    @State var photoSaveDay = "111元"
    @State var photoSaveMonth = "1111元"
    @State var photoSaveYear = "11111元"
    @State var storageSaveDay = "111元"
    @State var storageSaveMonth = "1111元"
    @State var storageSaveYear = "11112元"
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 0x01 / 255.0, green: 0x15 / 255.0, blue: 0x4d / 255.0)
                    //.frame(width: .infinity, height: .infinity)
                    .scaleEffect(x: 1.0, y: 1.5, anchor: .center)
                ScrollView {
                    VStack {
                        //顶部标题
                        HStack{
                            Text("能源e管家")
                                .font(.title)
                                .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                
                            Spacer()
                        }
                        //项目图片
                        Image("159600").resizable().scaledToFill()
                            .cornerRadius(10)
                            .shadow(radius: 15)
                        Group{
                            //天气
                            HStack{
                                Image(systemName: picName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height : 30)
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                Text(weather)
                                    .font(.caption)
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                Spacer()
                                Text(operatingTime)
                                    .font(.caption)
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                            }.onAppear{
                                getWeather()
                            }
                            //分割线
                            Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0)
                                .frame(height : 2)
                        }
                            
                        Group{
                            //项目简介的显示开关
                            HStack{
                                Spacer()
                                LottieAnimationView(name : "loading",play: $lottiePlaying)
                                    .frame(width: 100, height: 100, alignment: .center)
                                Spacer()
                            }.frame(height : 25)
                            .onTapGesture(count: 1, perform: {
                                isPresentationOpen.toggle()
                            })
                            //分割线
                            Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0)
                                .frame(height : 2)
                            //项目简介
                            if isPresentationOpen {
                                HStack{
                                    Text("虹桥基金小镇综合能源系统涵盖屋顶光伏，储能，直流微网等主要元素，减少小镇用电扩容改造费用400万元，每月节省需量电费5000元以上，为小镇提供清洁，高效，可靠的能源供应。")
                                        .font(.callout)
                                        .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                    Image("venture_pic").resizable().scaledToFit()
                                }.frame(height : isPresentationOpen ? 180 : 0)
                                Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0)
                                                        .frame(height : 2)
                            }
                        }
                        Group{
                            //两个饼图
                            HStack{
                                PieCharts(data: $firstPieChartData, description: "实时供能")
                                PieCharts(data: $secondPieChartData, description: "需量管理")
                            }.frame(height : 210)
                            .onAppear{
                                getPieData()
                            }
                            //分割线
                            Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0)
                                .frame(height : 2)
                        }
                        Group{
                            //光伏、储能功率曲线
                            VStack{
                                Text("光伏功率曲线")
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                LineCharts(lineData: $photoChartData, xData: $photoChartXData, description: "")
                                    .frame(height : 150)
                                //分割线
                                Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0)
                                    .frame(height : 2)
                                Text("储能功率曲线")
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                LineCharts(lineData: $storageChartData, xData: $storageChartXData, description: "")
                                    .frame(height : 150)
                            }
                            .onAppear{
                                initLineChartAndOthers()
                            }
                            //分割线
                            Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0)
                                .frame(height : 2)
                        }
                        //节省费用的内容
                        VStack{
                            HStack{
                                Text("储能节省\n电网支出")
                                    .font(.caption)
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                //Color(red:0x4a / 255.0,green: 0x88 / 255.0,blue : 0xcb / 255.0)
                                SaveCard(dateLabel: "日",
                                         backgroudColor: Color(red:0x4a / 255.0,green: 0x88 / 255.0,blue : 0xcb / 255.0), savedMoney: $storageSaveDay)
                                SaveCard(dateLabel: "月",
                                         backgroudColor: Color(red:0x4a / 255.0,green: 0x88 / 255.0,blue : 0xcb / 255.0), savedMoney: $storageSaveMonth)
                                SaveCard(dateLabel: "年",
                                         backgroudColor: Color(red:0x4a / 255.0,green: 0x88 / 255.0,blue : 0xcb / 255.0), savedMoney: $storageSaveYear)
                            }.frame(height : 50)
                            HStack{
                                Text("光伏节省\n电网支出")
                                    .font(.caption)
                                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                                SaveCard(dateLabel: "日",
                                         backgroudColor: Color(red:0x15 / 255.0,green: 0xa5 / 255.0,blue : 0x3f / 255.0), savedMoney: $photoSaveDay)
                                SaveCard(dateLabel: "月",
                                         backgroudColor: Color(red:0x15 / 255.0,green: 0xa5 / 255.0,blue : 0x3f / 255.0), savedMoney: $photoSaveMonth)
                                SaveCard(dateLabel: "年",
                                         backgroudColor: Color(red:0x15 / 255.0,green: 0xa5 / 255.0,blue : 0x3f / 255.0), savedMoney: $photoSaveYear)
                            }.frame(height : 50)
                        }
                        NavigationLink(destination: MainPage()){
                            Text("转到主页")
                        }.frame(height : 30)
                        .padding(.top,15)
                        Color(red: 0x01 / 255.0, green: 0x15 / 255.0, blue: 0x4d / 255.0)
                            .frame(height : 30)
                    }.offset(y : 50)
                }
            }.edgesIgnoringSafeArea(.top)
        }
    }
    
    //获取饼图的数据
    private func getPieData(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(homeBaseUrl)GetPieData",
                                 method: .post,
                                 headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                do{
                    let json = try JSON(data : data)
                    //解析第一个饼图的数据
                    debugPrint("正在初始化第一个饼图数据")
                    var pieData = [PieChartDataEntry]()
                    pieData.append(PieChartDataEntry(value: json["CityPower"].doubleValue, label: "市电"))
                    pieData.append(PieChartDataEntry(value: json["PhotovoltaicRoof"].doubleValue, label: "瓦片光伏"))
                    pieData.append(PieChartDataEntry(value: json["TabletPhotovoltaic"].doubleValue, label: "平板光伏"))
                    //初始化颜色
                    let firstColors = [
                        UIColor(red:0x4a / 255.0,green: 0x88 / 255.0,blue : 0xcb / 255.0, alpha: 1),
                        UIColor(red:0x5f / 255.0,green: 0xa1 / 255.0,blue : 0x36 / 255.0, alpha: 1),
                        UIColor(red:0xfd / 255.0,green: 0xb4 / 255.0,blue : 0x09 / 255.0, alpha: 1)
                    ]
                    //将上面产生的数据和颜色额绑定到Piedata上面
                    let dataSet = PieChartDataSet(entries: pieData,label: "")
                    dataSet.sliceSpace = 3
                    dataSet.selectionShift = 10
                    dataSet.colors = firstColors
                    let firstData = PieChartData(dataSet: dataSet)
                    firstData.setDrawValues(true)
                    firstData.setValueTextColor(UIColor.blue)
                    firstPieChartData = firstData
                    //解析第二个饼图的数据
                    debugPrint("正在初始化第二个饼图数据")
                    debugPrint(json["Used"].doubleValue)
                    let secondPieEntry = [
                        PieChartDataEntry(value: json["Used"].doubleValue, label: "已使用"),
                        PieChartDataEntry(value: json["Unused"].doubleValue, label: "未使用")
                    ]
                    //初始化第二个饼图的颜色
                    let secondColors = [
                        UIColor(red:0x5f / 255.0,green: 0xa1 / 255.0,blue : 0x37 / 255.0, alpha: 1),
                        UIColor(red:0xe6 / 255.0,green: 0x68 / 255.0,blue : 0x26 / 255.0, alpha: 1)
                    ]
                    //绑定到第二个饼图的数据上面
                    let secondPieSet = PieChartDataSet(entries: secondPieEntry,label: "")
                    secondPieSet.colors = secondColors
                    secondPieSet.sliceSpace = 3
                    secondPieSet.selectionShift = 10
                    let secondData = PieChartData(dataSet: secondPieSet)
                    secondData.setDrawValues(true)
                    secondData.setValueTextColor(UIColor.blue)
                    secondPieChartData = secondData
                }catch{
                    debugPrint("解析json数据发生错误")
                }
            case .failure(_):
                debugPrint("主页网络请求失败")
            }
        }
    }
    
    private func getWeather(){
        let weatherUrl = "http://wthrcdn.etouch.cn/weather_mini"
        let request = AF.request(weatherUrl,method: .get,parameters: ["city" : "上海"])
        request.responseJSON{
            response in
            switch response.result{
            
            case .success(_):
                guard let data = response.data else {
                    return
                }
                do{
                    let json = try JSON(data : data)
                    //解析天气数据
                    if json["status"].intValue == 1000 {
                        let predicate = json["data"]
                        let forecast = predicate["forecast"].arrayValue
                        let todayWeather = forecast[0]
                        let highTemp = todayWeather["high"].stringValue
                        let lowTemp = todayWeather["low"].stringValue
                        weather = "\(todayWeather["date"].stringValue) \(lowTemp.suffix(3))-\(highTemp.suffix(3)) \(todayWeather["type"].stringValue)"
                        switch todayWeather["type"].stringValue.suffix(1) {
                        case "晴":
                            picName = "sun.max.fill"
                            
                        case "阴":
                            picName = "cloud.fill"
                            
                        case "云":
                            picName = "cloud.sun.fill"
                            
                        case "雨":
                            picName = "cloud.heavyrain.fill"
                        default:
                            picName = "sun.max.fill"
                        }
                    }
                }catch{
                    debugPrint("解析json数据发生错误")
                }
                initData()
            case .failure(_):
                debugPrint("请求天气数据失败")
            }
        }
    }
    private func initData(){
        let referenceDate = "2020-11-2 00:00:00".toDate()!
        //改变系统正常运行的时间
        let date = Date()
        let interval = date.timeIntervalSince1970
        let days = (Int(interval) - Int(referenceDate.timeIntervalSince1970)) / (24 * 60 * 60) + 547
        operatingTime = "系统已正常运行\(days)天"
    }
    private func initLineChartAndOthers(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(homeBaseUrl)GetHomePageAlmostData",
                                 method: .post,
                                 headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                guard let data = response.data else {
                    return
                }
                do{
                    debugPrint(data)
                    let json = try JSON(data : data)
                    //初始化第一个折线图
                    var x1Data = [String]()
                    let firstXData = json["X1"].arrayValue
                    
                    for item in 0 ..< firstXData.count {
                        x1Data.append(firstXData[item].stringValue)
                    }
                    var firstList = [ChartDataEntry]()
                    let firstYData = json["Y1"].arrayValue
                    for index in 0 ..< firstYData.count {
                        firstList.append(ChartDataEntry(x: Double(index), y: firstYData[index].doubleValue))
                    }
                    let firstSet = LineChartDataSet(entries: firstList,label: "光伏发电功率曲线")
                    firstSet.setColor(UIColor.blue)
                    firstSet.valueTextColor = UIColor.blue
                    firstSet.circleRadius = 1
                    firstSet.circleHoleRadius = 0
                    photoChartData = LineChartData(dataSet: firstSet)
                    photoChartXData = x1Data
                    //初始化第二个折线图
                    var x2Data = [String]()
                    let secondXData = json["X2"].arrayValue
                    for index in 0 ..< secondXData.count{
                        let time = secondXData[index].stringValue
                        x2Data.append(String(time.split(separator: " ")[1]))
                    }
                    var secondList = [ChartDataEntry]()
                    let secondYData = json["Y2"].arrayValue
                    for index in 0 ..< secondYData.count{
                        secondList.append(ChartDataEntry(x: Double(index), y: secondYData[index].doubleValue))
                    }
                    let secondSet = LineChartDataSet(entries: secondList,label: "储能放电功率曲线")
                    secondSet.setColor(UIColor.blue)
                    secondSet.valueTextColor = UIColor.blue
                    secondSet.circleRadius = 1
                    secondSet.circleHoleRadius = 0
                    storageChartData = LineChartData(dataSet: secondSet)
                    storageChartXData = x2Data
                    //更新节省的费用信息
                    
                    photoSaveDay = "\(json["todayPSave"].intValue)元"
                    storageSaveDay = "\(json["todaySSave"].intValue)元"
                    photoSaveMonth = "\(json["monthPSave"].intValue)元"
                    storageSaveMonth = "\(json["monthSSave"].intValue)元"
                    photoSaveYear = "\(Int(json["yearPSave"].doubleValue * 0.83))元"
                    storageSaveYear = "\(json["yearSSave"].intValue)元"
                }catch{
                    debugPrint("转换json时发生错误")
                }
            case .failure(_):
                debugPrint("首页请求折线图数据发生错误")
            }
        }
    }
}

struct LandScape_Previews: PreviewProvider {
    static var previews: some View {
        LandScape()
    }
}

struct SaveCard: View {
    let dateLabel : String
    let backgroudColor : Color
    @Binding var savedMoney : String
    var body: some View {
        ZStack {
            backgroudColor
            HStack{
                VStack{
                    Spacer()
                    Text(dateLabel).font(.caption).foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
                }
                Spacer()
                Text(savedMoney)
                    .foregroundColor(Color(red:0x57 / 255.0,green: 0xef / 255.0,blue : 0xf5 / 255.0))
            }
        }.cornerRadius(5.0)
    }
}
