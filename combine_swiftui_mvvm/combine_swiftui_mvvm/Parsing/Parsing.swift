//
//  Parsing.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/20.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation
import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, GitHubError> {
    
    let decoder = JSONDecoder()
//    decoder.keyDecodingStrategy = .convertFromSnakeCase

    return Just(data)
        .decode(type: T.self, decoder: decoder)
        .mapError { error in
            .parsing(description: error.localizedDescription)
        }
        .eraseToAnyPublisher()
}
