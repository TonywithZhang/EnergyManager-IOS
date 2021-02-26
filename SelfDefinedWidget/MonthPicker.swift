//
//  MonthPicker.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/23.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI

struct MonthPicker: View {
    private var months : [String] = [String]()
    var body: some View {
        List{
            ForEach(0 ..< months.count / 3 + 1){index in
                if index == months.count / 3{
                    HStack{
                        ForEach(0 ..< months.count % 3){cell in
                            MonthPickerItem(monthText: months[months.count - (months.count % 3) + cell - 1])
                                .frame(maxWidth : 150)
                        }
                    }
                }else{
                    HStack{
                        MonthPickerItem(monthText: months[index * 3])
                            .frame(maxWidth : 150)
                        Spacer()
                        MonthPickerItem(monthText: months[index * 3 + 1])
                            .frame(maxWidth : 150)
                        Spacer()
                        MonthPickerItem(monthText: months[index * 3 + 2])
                            .frame(maxWidth : 150)
                    }
                }
            }
        }
    }
    init(startMonth : String,endMonth : String) {
        let startDate = Date(startMonth,format: "yyyy-MM")
        let startYear = startDate?.year
        let startMonth1 = startDate?.month
        let endDate = Date(endMonth,format: "yyyy-MM")
        let endYear = endDate?.year
        let endMonth1 = endDate?.month
        if startYear == endYear{
            for item in startMonth1! ... endMonth1! {
                months.append("\(startYear ?? 2021)-\(item)")
            }
        }
        else if (endYear! - startYear!) == 1{
            for item in startMonth1! ... 12 {
                months.append("\(startYear ?? 2021)-\(item)")
            }
            for item in 1 ... endMonth1! {
                months.append("\(endYear ?? 2021)-\(item)")
            }
        }
        else{
            for item in startMonth1! ... 12 {
                months.append("\(startYear ?? 2021)-\(item)")
            }
            for year in startYear! + 1 ..< endYear! {
                for month in 1 ... 12 {
                    months.append("\(year)-\(month)")
                }
            }
            for item in 1 ... endMonth1! {
                months.append("\(endYear ?? 2021)-\(item)")
            }
        }
    }
}

struct MonthPicker_Previews: PreviewProvider {
    static var previews: some View {
        MonthPicker(startMonth: "2019-01", endMonth: "2022-11")
    }
}
