//
//  UserPage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/28.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import SwiftyJSON
import Alamofire

struct UserPage: View {
    @State var userList = [UserData]()
    var body: some View {
        ScrollView {
            ForEach(userList){
                user in
                UserBean(user: user)
                Color.black.frame(height : 2)
            }
        }.navigationBarTitle("小镇用户",displayMode: .inline)
        .onAppear{
            getUserData()
        }
    }
    private func getUserData(){
        let cookie = UserDefaults.standard.string(forKey: "Cookie")!
        var header = HTTPHeaders()
        header.add(name: "Cookie", value: cookie)
        let request = AF.request("\(homeBaseUrl)GetVentureUserData",
                                 method: .post,
                                 headers: header)
        request.responseJSON{
            response in
            switch response.result{
            case .success(_):
                if let data = response.data{
                    do{
                        let json = try JSON(data : data)
                        let users = json["data"].arrayValue
                        userList.removeAll()
                        for item in 0 ..< users.count {
                            let currentUser = users[item]
                            userList.append(UserData(name: currentUser["name"].stringValue, type: currentUser["userType"].stringValue,
                                                     volta: currentUser["U"].stringValue,
                                                     stream: currentUser["I"].stringValue,
                                                     power: currentUser["power"].stringValue,
                                                     cost: currentUser["cost"].stringValue))
                        }
                    }catch{
                        debugPrint("用户界面解析json发生错误")
                    }
                }
            case .failure(_):
                debugPrint("用户界面网络请求发生错误")
            }
        }
    }
}

struct UserPage_Previews: PreviewProvider {
    static var previews: some View {
        UserPage()
    }
}
struct UserData : Identifiable {
    let id = UUID()
    let name : String
    let type : String
    let volta : String
    let stream : String
    let power : String
    let cost : String
}
