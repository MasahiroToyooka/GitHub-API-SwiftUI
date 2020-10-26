//
//  ContentView.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/15.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            List {
                searchTF
                
                if viewModel.dataSource.isEmpty {
                    emptyView
                } else {
                    userSection
                }
            }

        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Weather")

    }
}


private extension HomeView {
    
    var searchTF: some View {
        HStack {
             TextField("Seach...", text: $viewModel.searchText)
        }
    }
    
    var userSection: some View {
        Section {
//            NavigationLink(destination: WebView()) {
//                ForEach(viewModel.dataSource, content: UserRow.init(viewModel:))
//            }
            ForEach(viewModel.dataSource, content: UserRow.init(viewModel:))
        }
    }
    
    var emptyView: some View {
        Section {
            Text("検索結果はありませんでした。。")
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}
