//
//  StatisticStorageModel.swift
//  能源管家
//
//  Created by 张庆德 on 2021/3/2.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation

///
struct StatisticStorageModel : Codable {
    
    var count: Int?
    
    var time: [String] = []
    
    var data: [SData] = []
}

///
struct SData: Codable {
    
    var type: String?
    
    var data: [Double] = []
    
    var name: String?
    
    var stack: String?
}

