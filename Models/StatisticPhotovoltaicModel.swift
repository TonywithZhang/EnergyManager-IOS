//
//  StatisticPhotovoltaicModel.swift
//  能源管家
//
//  Created by 张庆德 on 2021/3/1.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation

///
struct StatisticPhotovoltaicModel: Codable {
    
    var time: [String] = []
    
    var count: Int?
    ///
    var data: PData?
}

///
struct PData: Codable {
    
    var data: [Double] = []
    
    var type: String?
}

