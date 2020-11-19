//
//  ContentView.swift
//  Kc Admin
//
//  Created by 隔壁家的电冰箱。 on 9/9/20.
//  Copyright © 2020 隔壁家的电冰箱。. All rights reserved.
//

import SwiftUI

struct AlarmTable: View {
    var text_size = size.width / 5
    @Binding var data : [AlarmInformation]
    var body: some View {
        NavigationView{
            VStack{
                //表头
                HStack(spacing: 0){
                    HStack{
                        Spacer()
                        Text("时间")
                        Spacer()
                        Divider()
                    }.frame(width: text_size, height: 20)
                    HStack{
                        Spacer()
                        Text("状态")
                        Spacer()
                        Divider()
                    }.frame(width:text_size, height: 20)
                    HStack{
                        Spacer()
                        Text("报警源")
                        Spacer()
                        Divider()
                    }.frame(width:text_size, height: 20)
                    HStack{
                        Spacer()
                        Text("信息")
                        Spacer()
                        Divider()
                    }.frame(width: text_size, height: 20)
                    HStack{
                        Spacer()
                        Text("操作")
                        Spacer()
                    }.frame(width: text_size, height: 20)
                    
                }
                .frame(width: UIScreen.main.bounds.width)
                //.background(Color.gray)
                Divider()
                
                //Spacer()
                ScrollView(.vertical,showsIndicators: true, content: {
                    ForEach(data){item in
                        HStack{
                            HStack{
                                Spacer()
                                Text(item.time).minimumScaleFactor(0.3)
                                Spacer()
                                Divider()
                            }.frame(width: self.text_size, height: 20)
                            HStack{
                                Spacer()
                                Text(item.state).minimumScaleFactor(0.3)
                                Spacer()
                                Divider()
                            }.frame(width:self.text_size, height: 20)
                            HStack{
                                Spacer()
                                Text(item.resource).minimumScaleFactor(0.3)
                                Spacer()
                                Divider()
                            }.frame(width: self.text_size, height: 20)
                            HStack{
                                Spacer()
                                Text(item.information).minimumScaleFactor(0.3)
                                Spacer()
                                Divider()
                            }.frame(width: self.text_size, height: 20)
                            
                            HStack{
                                Spacer()
                                NavigationLink(destination:Text("demo")) {
                                    Text("操作").minimumScaleFactor(0.3)
                                }
                                Spacer()
                            }.frame(width: self.text_size, height: 20)
                            
                        }
                        .padding()
                        .background(Color.white)
                        //.overlay(RoundedRectangle(cornerRadius: 3).stroke(Color.black,lineWidth: 1))
                        Divider()
                        Spacer()
                    }
                })
            }
        .navigationBarTitle("")
        .navigationBarHidden(true)
        }
        
    }
}

struct AlarmInformation : Identifiable{
    let id = UUID()
    let time : String
    let state : String
    let resource : String
    let information : String
}

struct AlarmTable_Previews: PreviewProvider {
    @State private static var data = [
        AlarmInformation(time: "今天", state: "良好", resource: "不知源头", information: "测试"),
        AlarmInformation(time: "今天", state: "良好", resource: "不知源头", information: "测试")
    ]
    static var previews: some View {
        AlarmTable(data: $data)
    }
}
