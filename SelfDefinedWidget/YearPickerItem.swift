//
//  YearPickerItem.swift
//  能源管家
//
//  Created by 张庆德 on 2021/2/24.
//  Copyright © 2021 张庆德. All rights reserved.
//

import SwiftUI

struct YearPickerItem: View {
    @EnvironmentObject var dateList : MultiDate
    let year : Int
    @State private var isYearSelected = false
    var body: some View {
        HStack {
            Text(String(year))
            Spacer()
            if isYearSelected {
                Image(systemName: "checkmark")
                    .foregroundColor(.red)
            }
        }
        .padding()
        .contentShape(Rectangle())
        .onTapGesture {
            isYearSelected.toggle()
            if isYearSelected{
                dateList.yearList.append(year)
            }else{
                dateList.yearList.remove(at: dateList.yearList.firstIndex(of: year)!)
            }
        }
    }
}

struct YearPickerItem_Previews: PreviewProvider {
    static var previews: some View {
        YearPickerItem(year: 2020)
    }
}
