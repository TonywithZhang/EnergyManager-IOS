//
//  DeviceInstruction.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/27.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct DeviceInstruction: View {
    let device : Device
    var body: some View {
        VStack  {
            HStack{
                Text(device.deviceName)
                    .font(.callout)
                Spacer()
                Text(device.operatingHours)
                    .font(.caption)
            }
            Divider()
            HStack{
                SingleItemCard(width: Double(size.width) / 5,title: "电压",items: [device.voltaA,device.voltaB,device.voltaC])
                SingleItemCard(width: Double(size.width) / 5,title: "电流",items: [device.streamA,device.streamB,device.streamC])
                SingleItemCard(width: Double(size.width) * 0.27,title: "功率",items: [device.power])
                SingleItemCard(width: Double(size.width) * 0.27,title: "电量",items: [device.produceToday,device.producetotally])
            }
        }.frame(width: size.width,height : 210)
    }
}

struct DeviceInstruction_Previews: PreviewProvider {
    static var previews: some View {
        DeviceInstruction(device: Device(deviceName: "逆变器1", voltaA: "A相：221.0V", voltaB: "B相：220V", voltaC: "C相：223V", streamA: "A相：34A", streamB: "B相：45A", streamC: "C相：34A", power: "总有功功率：34344w", produceToday: "日发电量：1293kWh", producetotally: "总发电量：20394kWh", operatingHours: "正在运行 运行时间：12343h"))
    }
}

struct SingleItemCard: View {
    let width : Double
    let title : String
    let items : [String]
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 8.0, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                .stroke(Color.blue,lineWidth: 2.0)
                .padding(8)
            VStack {
                Text(title).font(.callout).background(Color.white)
                Spacer()
                ForEach(items,id: \.self){ item in
                    Text(item)
                        .font(.caption)
                    Spacer()
                }
            }.frame(width: CGFloat(width) - 20, height: .infinity, alignment: .center)
        }.frame(width: CGFloat(width), height: .infinity, alignment: .center)
    }
}
