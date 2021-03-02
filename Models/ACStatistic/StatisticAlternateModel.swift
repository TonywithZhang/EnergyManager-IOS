//
//  StatisticCityPowerModel.swift
//  能源管家
//
//  Created by 张庆德 on 2021/3/1.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation


///
struct StatisticCityPowerModel: Codable {
    
    var aTime: [String] = []
    ///
    var bData: BData?
    
    var bTime: [String] = []
    
    var bCount: Int?
    ///
    var aData: AData?
    
    var aCount: Int?
}

///
struct BData: Codable {
    
    var data: [Int] = []
    
    var type: String?
}

///
struct AData: Codable {
    
    var data: [Int] = []
    
    var type: String?
}

