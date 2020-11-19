//
//  ContentView.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/6/29.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON


struct ContentView: View {
    @State var userName : String = ""
    @State var password : String = ""
    @State var isLogging = false
    @State var isLoggedIn = false
    @State var loginFailed = false
    private let images = [
        UIImage(named: "159600"),
        UIImage(named: "honor_labels"),
        UIImage(named: "roof_photo"),
        UIImage(named: "pile"),
        UIImage(named: "smart_led"),
    ]
    //保存一些数据
    private let dataBase = UserDefaults.standard
    
    var body: some View {
        ZStack {
            if !isLoggedIn{
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text("能源管家")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .padding(.top,40)
                            Spacer()
                        }
   
                        HKCBannerView(banner_url: [], banner_images: images)
                            .frame(width: size.width, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }.background(/*@START_MENU_TOKEN@*/Color.blue/*@END_MENU_TOKEN@*/)
                    Form {
                        Section{
                            TextField("请输入用户名", text: $userName)
                                
                            SecureField("请输入密码", text: $password)

                        }
                        
                        Section{
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isLogging.toggle()
                                    //然后进行网络请求
                                    //创建请求头
                                    var header = HTTPHeaders()
                                    header.add(name: "User-Agent", value: appleUserAgent)
                                    //创建请求参数，账号或者密码
                                    let parameters = ["UserName": userName,"Password" : password]
                                    
                                    let request = AF.request(loginUrl,
                                                             method: .post,
                                                             parameters: parameters,
                                                             headers: header)
                                    request.responseJSON{
                                        response in
                                        //处理返回的登录结果
                                        var loginResult = false
                                        switch response.result{
                                        case .success(_):
                                            //打印响应体
                                            debugPrint("得到的服务器响应内容为：")
                                            if let data = response.data{
                                                let json = JSON(data)
                                                debugPrint(json)
                                            }
                                            
                                            //得到所有的响应头
                                            let responseHeader = response.response?.allHeaderFields
                                            for (k,v) in responseHeader! {
                                                debugPrint(k,v,separator:" ：")
                                                if k as! String == "Set-Cookie" {
                                                    loginResult = true
                                                    self.isLoggedIn = true
                                                    let value = v as! String
                                                    let cookieIndex = value.firstIndex(of: ";")!
                                                    let cookie = value[value.startIndex ..< cookieIndex]
                                                    dataBase.set(cookie,forKey: "Cookie")
                                                    dataBase.set(true,forKey: "isloggedIn")
                                                }
                                            }
                                        case .failure(_):
                                            debugPrint("网络请求失败")
                                        }
                                        if !loginResult{
                                            self.isLogging = false
                                            self.loginFailed = true
                                        }
                                    }
                                }) {
                                    Text("点击登录")
                                }
                                .alert(isPresented: $loginFailed, content: {
                                    Alert(title: Text("提示"), message: Text("账号或者密码错误"), dismissButton: .default(Text("确定")))
                                })
                                Spacer()
                            }
                        }
                    }
                }.blur(radius: isLogging ? 20 : 0)
                .animation(.easeInOut)
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    LottieAnimationView(name: "loading_icon", play: $isLogging)
                        .frame(width: 300, height: 300, alignment: .center)
                    Text("正在登录...")
                }
                .offset(x: 0, y: isLogging ? 0 : size.height/2 + 100)
                .animation(.easeInOut)
            }else{
                //MainPage()
                LandScape()
            }
        }
        .onAppear{
            isLoggedIn = dataBase.bool(forKey: "isloggedIn")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

let size = UIScreen.main.bounds
let loginUrl = "http://101.132.236.192:8001/Account/Login"
var appleUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.89 Safari/537.36 Edg/84.0.522.40"
let homeBaseUrl = "http://101.132.236.192:8001/Home/"
let storageBaseUrl = "http://101.132.236.192:8008/SIManage/LoadEnergyStorage/"
