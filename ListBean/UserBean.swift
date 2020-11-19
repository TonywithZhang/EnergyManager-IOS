//
//  UserBean.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/28.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct UserBean: View {
    let user : UserData
    var body: some View {
        VStack {
            HStack {
                Text(user.name)
                Spacer()
                Text(user.type)
            }
            Divider()
            HStack {
                Text(user.volta)
                Spacer()
                Text(user.stream)
            }
            Divider()
            HStack {
                Text(user.power)
                Spacer()
                Text(user.cost)
            }
        }
    }
}

struct UserBean_Previews: PreviewProvider {
    static var previews: some View {
        UserBean(user: UserData(name: "D46", type: "商业配套", volta: "230v", stream: "123A", power: "12314w", cost: "12312kwh"))
    }
}
