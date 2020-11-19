//
//  Feedback.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/6.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct Feedback: View {
    @State private var feedBack = ""
    var body: some View {
        VStack {
            Section {
                Text("问题反馈")
            }
            Form{
                Section {
                    HStack {
                        Text("问题描述：")
                        
                        TextField("", text: $feedBack)
                    }.frame(height : 150)
                }
                Section{
                    HStack{
                        Spacer()
                        Button(action : {}){
                            Text("提交问题")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct Feedback_Previews: PreviewProvider {
    static var previews: some View {
        Feedback()
    }
}
