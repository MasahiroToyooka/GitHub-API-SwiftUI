//
//  WebView.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/17.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI

struct DetailWebView: View {
    
    let user: GitHubResponse.User
    
//    /// アクション
//    @State private var action: WebView.Action = .none
//    /// 戻れるか
//    @State private var canGoBack: Bool = false
//    /// 進めるか
//    @State private var canGoForward: Bool = false
//    /// 読み込みの進捗状況
//    @State private var estimatedProgress: Double = 0.0
//    /// ローディング中かどうか
//    @State private var isLoading: Bool = false
//    /// ページタイトル
//    @State private var pageTitle: String = ""
    
    init(user: GitHubResponse.User) {
        self.user = user
    }
    
    var body: some View {
//        NavigationView {
//            VStack(spacing: 0) {
//                if isLoading {
//                    ProgressBarView(estimatedProgress: estimatedProgress)
//                }
//                WebView(url: URL(string: user.htmlUrl)!,
//                        action: $action,
//                        canGoBack: $canGoBack,
//                        canGoForward: $canGoForward,
//                        estimatedProgress: $estimatedProgress,
//                        isLoading: $isLoading,
//                        pageTitle: $pageTitle)
//                    .navigationBarTitle(Text(pageTitle), displayMode: .inline)
//                WebToolBarView(action: $action,
//                               canGoBack: canGoBack,
//                               canGoForward: canGoForward)
//            }
//        }
        MyWebView(urlString: user.htmlUrl)
            .navigationBarTitle(Text(user.login), displayMode: .inline)
    }
}
