//
//  StatisticUserModel.swift
//  能源管家
//
//  Created by 张庆德 on 2021/3/2.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation

///
struct StatisticUserModel: Codable {
    
    var time: [String] = []
    
    var count: Int?
    ///
    var data: UData?
}

///
struct UData: Codable {
    
    var type: String?
    
    var data: [Double] = []
}

