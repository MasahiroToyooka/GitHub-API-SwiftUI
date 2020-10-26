//
//  UserRowModel.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/20.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation
import SwiftUI

struct UserRowViewModel: Identifiable {
    
    var id: String {
        return name + type + avatar
    }

    private let item: GitHubResponse.User
    
    var name: String {
        return item.login
    }
    
    var type: String {
        return item.type
    }
    
    var avatar: String {
        return item.avatarUrl
    }
    
    init(item: GitHubResponse.User) {
        self.item = item
    }
}


extension UserRowViewModel {
    var userDetailView: some View {
        return DetailWebView(user: item)
    }
}

extension UserRowViewModel: Hashable {
  static func == (lhs: UserRowViewModel, rhs: UserRowViewModel) -> Bool {
    return lhs.name == rhs.name
  }

  func hash(into hasher: inout Hasher) {
    hasher.combine(self.name)
  }
}
