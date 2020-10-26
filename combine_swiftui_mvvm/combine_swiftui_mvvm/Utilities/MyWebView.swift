//
//  MyWebView.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/26.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI
import WebKit

struct MyWebView: UIViewRepresentable {
    let urlString: String
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        guard let url = URL(string: urlString) else {
            return
        }
        uiView.load(URLRequest(url: url))
    }
}

struct MyWebView_Previews: PreviewProvider {
    static var previews: some View {
        MyWebView(urlString: "https://www.google.com/")
    }
}
