//
//  UserRow.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/20.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI

struct UserRow: View {
    private let viewModel: UserRowViewModel
    
    init(viewModel: UserRowViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        
        NavigationLink(destination: viewModel.userDetailView) {
            HStack(alignment: .center, spacing: 20) {
                URLImageView(viewModel: .init(url: viewModel.avatar))
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(8)
                VStack {
                    Text(viewModel.name)
                        .font(.headline)
                    Text(viewModel.type)
                }
            }
            .padding(.horizontal, 10)
            .padding(.vertical, 10)
        }
    }
}
