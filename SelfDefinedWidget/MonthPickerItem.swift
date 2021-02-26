//
//  MonthPickerItem.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/23.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI

struct MonthPickerItem: View {
    @EnvironmentObject var dateList : MultiDate
    let monthText : String
    @State private var isSelected = false
    var body: some View {
        ZStack {
            if isSelected{
                RoundedRectangle(cornerRadius: 5).fill(Color.red)
            }
            Text(monthText)
                .fontWeight(.bold)
        }
        .onTapGesture {
            isSelected.toggle()
            if isSelected{
                dateList.monthList.append(monthText)
            }else{
                dateList.monthList.remove(at: dateList.monthList.firstIndex(of: monthText)!)
            }
        }
    }
}

struct MonthPickerItem_Previews: PreviewProvider {
    static var previews: some View {
        MonthPickerItem(monthText: "2021-01")
    }
}
