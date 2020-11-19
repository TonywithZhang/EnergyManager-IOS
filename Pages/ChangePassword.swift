//
//  ChangePassword.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/6.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct ChangePassword: View {
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    var body: some View {
        VStack {
            Section {
                Text("密码修改")
            }
            Form{
                Section{
                    SecureField("旧密码", text: $oldPassword)
                    SecureField("新密码", text: $newPassword)
                    SecureField("确认密码", text: $confirmPassword)
                }
                Section{
                    
                    HStack {
                        Spacer()
                        Button(action :{
                            
                        }){
                            Text("提交修改")
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ChangePassword_Previews: PreviewProvider {
    static var previews: some View {
        ChangePassword()
    }
}
