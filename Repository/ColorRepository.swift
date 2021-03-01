//
//  ColorRepository.swift
//  能源管家
//
//  Created by 张庆德 on 2021/3/1.
//  Copyright © 2021 张庆德. All rights reserved.
//

import Foundation
import SwiftUI

class ColorRepositoty {
    private let colors = [
        UIColor.black
        ,UIColor.blue
        ,UIColor.yellow
        ,UIColor.cyan
        ,UIColor.brown
        ,UIColor.darkGray
        ,UIColor.magenta
        ,UIColor.red
        ,UIColor.systemTeal]
    
    private var index = 0
    
    func nextColor() -> UIColor{
        if index == colors.count - 1 {
            index = 0
        }
        let color = colors[index]
        index += 1
        return color
    }
}
