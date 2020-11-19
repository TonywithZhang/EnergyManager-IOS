//
//  User.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/11/6.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct User: View {
    var body: some View {
        NavigationView {
            VStack(alignment : .leading) {
                HStack{
                    Image(systemName: "person.circle")
                        .font(.largeTitle)
                    Text("admin")
                }
                .padding()
                Section {
                    List {
                        NavigationLink(destination : ChangePassword()) {
                            HStack {
                                Image(systemName: "lock.rectangle")
                                Text("密码修改")
                            }
                        }
                        
                        .navigationBarHidden(true)
                        NavigationLink(destination : PersonalInformation()) {
                            HStack {
                                Image(systemName: "rectangle.stack.person.crop")
                                Text("个人信息")
                            }
                        }
                        .navigationBarHidden(true)
                        NavigationLink(destination : Feedback()) {
                            HStack {
                                Image(systemName: "rectangle.and.pencil.and.ellipsis")
                                Text("问题反馈")
                            }
                        }
                        .navigationBarHidden(true)
                    }
                }.cornerRadius(10)
                Spacer()
            }
        }
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        User()
    }
}
