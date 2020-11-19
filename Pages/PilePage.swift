//
//  PilePage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/28.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct PilePage: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("充电桩")
                    Spacer()
                }.frame(width: 100, height: .infinity, alignment: .center)
                Divider()
                VStack{
                    Text("今日充电电量")
                    Spacer()
                    Text("峰时段电量：")
                    Spacer()
                    Text("平时段电量：")
                    Spacer()
                    Text("谷时段电量：")
                    Spacer()
                }.frame(width: .infinity, height: .infinity, alignment: .center)
            }.frame(width: size.width, height: 200, alignment: .leading)
            Divider()
            HStack {
                VStack {
                    Text("调峰储能")
                    Spacer()
                }.frame(width: 100, height: .infinity, alignment: .center)
                Divider()
                VStack{
                    Text("累计充电电量")
                    Spacer()
                    Text("峰时段电量：")
                    Spacer()
                    Text("平时段电量：")
                    Spacer()
                    Text("谷时段电量：")
                    Spacer()
                }.frame(width: .infinity, height: .infinity, alignment: .center)
            }.frame(width: size.width, height: 200, alignment: .leading)
            Spacer()
        }.navigationBarTitle("充电桩",displayMode: .inline)
    }
}

struct PilePage_Previews: PreviewProvider {
    static var previews: some View {
        PilePage()
    }
}
