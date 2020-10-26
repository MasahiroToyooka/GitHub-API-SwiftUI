//
//  GitHubData.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/21.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation

struct GitHubResponse: Codable {
    
    let items: [User]
    
    struct User: Codable {
        let login: String
        let avatarUrl: String
        let htmlUrl: String
        let type: String

        enum CodingKeys: String, CodingKey {
            case login
            case avatarUrl = "avatar_url"
            case htmlUrl = "html_url"
            case type
        }
    }
}
