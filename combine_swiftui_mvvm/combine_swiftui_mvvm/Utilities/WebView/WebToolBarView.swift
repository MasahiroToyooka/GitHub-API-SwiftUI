//
//  WebToolBarView.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/24.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI

struct WebToolBarView: View {

    /// アクション
    @Binding var action: WebView.Action
    /// 戻れるか
    var canGoBack: Bool
    /// 進めるか
    var canGoForward: Bool

    var body: some View {
        VStack() {
            Divider()
            HStack(spacing: 16) {
                Button("Back") {
                    self.action = .goBack
                }.disabled(!canGoBack)
                
                Button("Forward") {
                    self.action = .goForward
                }.disabled(!canGoForward)
                
                Spacer()
                
                Button("Reload") {
                    self.action = .reload
                }
            }
            .padding(.top, 8)
            .padding(.horizontal, 16)
            Spacer()
        }.frame(height: 60)
    }
}
