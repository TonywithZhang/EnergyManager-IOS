//
//  CircleImage.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/9/8.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI

struct CircleImage: View {
    var body: some View {
        NavigationView{
            Text("123")
                .navigationBarTitle("转到下一个",displayMode: .inline)
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage()
    }
}
