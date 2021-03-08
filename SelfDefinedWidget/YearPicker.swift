//
//  YearPicker.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/24.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI

struct YearPicker: View {
    private var years = [Int]()
    var body: some View {
        List(years,id : \.self) { item in
            YearPickerItem(year: item)
        }
    }
    
    init(startYear : Int,endYear : Int) {
        for item in startYear ... endYear {
            years.append(item) 
        }
    }
}

struct YearPicker_Previews: PreviewProvider {
    static var previews: some View {
        YearPicker(startYear: 2019, endYear: 2022)
    }
}
