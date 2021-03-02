//
//  DatesPickerView.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/26.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI

struct DatesPickerView: View {
    @State private var selectedDays = ""
    let dateList : MultiDate
    
    let showUserSelection  : Bool
    @State private var showUserPicker = false
    @State private var user = ""
    @Binding var selectedIndex : Int
    
    @State private var showDayPicker = false
    @State private var selectedMonths = ""
    @State private var showMonthPicker = false
    @State private var selectedYears = ""
    @State private var showYearPicker = false
    
    private let rkManager = RKManager(calendar: Calendar.current, minimumDate: Date("2020-03-01",format: "yyyy-MM-dd")!, maximumDate: Date(), mode: 3)
    
    var body: some View {
        VStack {
            Image(systemName: "chevron.compact.down")
                .resizable()
                .scaledToFit()
                .foregroundColor(.black)
                .frame(height : 15)
                .padding()
            Form {
                VStack {
                    //选择用户的界面
                    if showUserSelection{
                        HStack {
                            Text("用户")
                            Spacer()
                            TextField("默认A56", text: $user)
                                .frame(width : 120)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onTapGesture {
                                    showUserPicker = true
                                }
                                .sheet(isPresented: $showUserPicker, onDismiss: {
                                    user = users[selectedIndex]
                                }, content: {
                                    VStack {
                                        Image(systemName: "chevron.compact.down")
                                            .resizable()
                                            .scaledToFit()
                                            .foregroundColor(.black)
                                            .frame(height : 15)
                                            .padding()
                                        List(users,id : \.self){ single in
                                            HStack{
                                                Text(single)
                                                Spacer()
                                                if selectedIndex == users.firstIndex(of: single){
                                                    Image(systemName: "checkmark")
                                                        .foregroundColor(.red)
                                                }
                                            }.contentShape(Rectangle())
                                            .onTapGesture{
                                                selectedIndex = users.firstIndex(of: single)!
                                            }
                                        }
                                    }
                                })
                        }
                        Divider()
                    }
                    HStack {
                        Text("日")
                        Spacer()
                        TextField("选择日期", text: $selectedDays)
                            .frame(width : 120)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                showDayPicker = true
                            }
                            .sheet(isPresented: $showDayPicker, onDismiss: {
                                let selectedDates = rkManager.selectedDates.map{
                                    date -> String in
                                    let formatter = DateFormatter()
                                    formatter.dateFormat = "yyyy-MM-dd"
                                    return formatter.string(from: date)
                                }
                                selectedDays = selectedDates.joined(separator: ",")
                                dateList.dayList = selectedDates
                                dateList.days = selectedDays
                            }, content: {
                                VStack {
                                    Image(systemName: "chevron.compact.down")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .frame(height : 15)
                                        .padding()
                                    RKViewController(isPresented: .constant(true), rkManager: rkManager)
                                }
                            })
                        //                        DatePicker("请选择一个日期", selection: $cityDate,displayedComponents: .date)
                        //                            .labelsHidden()
                    }
                    Divider()
                    HStack {
                        Text("月")
                        Spacer()
                        TextField("选择月份", text: $selectedMonths)
                            .frame(width : 120)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                showMonthPicker = true
                            }
                            .sheet(isPresented: $showMonthPicker, onDismiss: {
                                selectedMonths = dateList.monthList.joined(separator: ",")
                                dateList.months = selectedMonths
                            }, content: {
                                VStack {
                                    Image(systemName: "chevron.compact.down")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .frame(height : 15)
                                        .padding()
                                    MonthPicker(startMonth: "2020-01", endMonth: "\(Date().year)-\(Date().month)")
                                        .environmentObject(dateList)
                                }
                            })
                    }
                    Divider()
                    HStack {
                        Text("年")
                        Spacer()
                        TextField("选择年份", text: $selectedYears)
                            .frame(width : 120)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .onTapGesture {
                                showYearPicker = true
                            }
                            .sheet(isPresented: $showYearPicker, onDismiss: {
                                let years = dateList.yearList.map{
                                    year -> String in
                                    String(year)
                                }
                                selectedYears = years.joined(separator: ",")
                                dateList.years = selectedYears
                            }, content: {
                                VStack {
                                    Image(systemName: "chevron.compact.down")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.black)
                                        .frame(height : 15)
                                        .padding()
                                    YearPicker(startYear: 2020, endYear: 2021)
                                        .environmentObject(dateList)
                                }
                            })
                    }
                }
            }
        }
    }
}

struct DatesPickerView_Previews: PreviewProvider {
    @State static var index = 0
    static var previews: some View {
        DatesPickerView(dateList: MultiDate(),showUserSelection: true,selectedIndex: $index)
    }
}
let users = ["A56","C55","F57","D46","VVIP会所","配套酒店公寓","小镇餐厅","多功能厅","晨响一层空调","晨响二层空调","综合办公楼","游泳池室外电源","游泳池总","游泳池大屏"]
