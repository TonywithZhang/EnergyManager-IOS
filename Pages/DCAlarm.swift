//
//  DCAlarm.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/5.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct DCAlarm: View {
    
    @State private var startTime1 = Date()
    @State private var showStartTimePicker1 = false
    @State private var startTimeText1 = "起始时间"
    @State private var endTime1 = Date()
    @State private var showEndTimePicker1 = false
    @State private var endTimeText1 = "截止时间"
    
    @State private var cityData = [AlarmInformation]()
    
    var body: some View {
        ScrollView {
            VStack {
                //市电报警源
                VStack {
                    //市电图表
                    VStack {
                        HStack(spacing : 0) {
                            Text("市电")
                            Spacer()
                            TextField("起始时间", text: $startTimeText1).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showStartTimePicker1.toggle()
                                })
                                .sheet(isPresented: $showStartTimePicker1,onDismiss:{
                                    self.startTimeText1 = "\(startTime1.year)-\(startTime1.month)-\(startTime1.day)"
                                }, content: {
                                    startTimePicker1
                                })
                            Divider()
                            TextField("截止时间", text: $endTimeText1).frame(width : 100)
                                .background(Rectangle().stroke(Color.blue))
                                .font(.subheadline)
                                .onTapGesture(count: 1, perform: {
                                    self.showEndTimePicker1.toggle()
                                })
                                .sheet(isPresented: $showEndTimePicker1,onDismiss:{
                                    self.endTimeText1 = "\(endTime1.year)-\(endTime1.month)-\(endTime1.day)"
                                }, content: {
                                    endTimePicker1
                                })
                            Button(action : {
                                getData(index: 1, startTime: startTimeText1, endTime: endTimeText1)
                            }){
                                Text("查询").font(.headline).foregroundColor(.white)
                            }.background(Rectangle().fill(Color.blue))
                        }.frame(height : 30)
                        AlarmTable(data: $cityData)
                            .frame(minHeight : 200,maxHeight: 250)
                        Spacer()
                    }
                    
                    
                }
            }
        }
        
        
        
    }
    
    private var startTimePicker1 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $startTime1,displayedComponents:.date)
                .labelsHidden()
        }
    }
    private var endTimePicker1 : some View{
        Form {
            DatePicker("请选择一个日期", selection: $endTime1,displayedComponents:.date)
                .labelsHidden()
        }
    }
    
    private func getData(index : Int,startTime : String, endTime : String){
        
    }
}

struct DCAlarm_Previews: PreviewProvider {
    static var previews: some View {
        DCAlarm()
    }
}
