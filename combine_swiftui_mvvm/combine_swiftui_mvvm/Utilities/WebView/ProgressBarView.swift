//
//  ProgressBarView.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/24.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI

struct ProgressBarView: View {

    /// 読み込みの進捗状況
    var estimatedProgress: Double

    var body: some View {
        VStack {
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(Color.gray)
                    .opacity(0.3)
                    .frame(width: geometry.size.width)
                Rectangle()
                    .foregroundColor(Color.blue)
                    .frame(width: geometry.size.width * CGFloat(self.estimatedProgress))
            }
        }.frame(height: 3.0)
    }
}
