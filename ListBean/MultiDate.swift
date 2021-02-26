//
//  MultiDate.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/24.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation

class MultiDate : ObservableObject{
    @Published var dayList = [String]()
    @Published var monthList = [String]()
    @Published var yearList = [Int]()
    @Published var days = ""
    @Published var months = ""
    @Published var years = ""
}
