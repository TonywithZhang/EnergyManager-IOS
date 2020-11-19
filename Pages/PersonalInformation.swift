//
//  PersonalInformation.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/6.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct PersonalInformation: View {
    var body: some View {
        VStack {
            Section {
               Text("个人信息")
            }
            Form{
                Section{
                    Text("昵称：")
                    Text("公司：")
                    Text("手机号：")
                    Text("邮箱：")
                    Text("身份:")
                }
                
            }
        }
    }
}

struct PersonalInformation_Previews: PreviewProvider {
    static var previews: some View {
        PersonalInformation()
    }
}
