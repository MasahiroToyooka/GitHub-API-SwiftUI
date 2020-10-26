//
//  GitHubFetcher.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/16.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation
import Combine


enum GitHubError: Error {
  case parsing(description: String)
  case network(description: String)
}

protocol GitHubFetchable {
    func githubUser(user: String) -> AnyPublisher<GitHubResponse, GitHubError>
}


class GitHubFetcher {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
}

extension GitHubFetcher: GitHubFetchable {
    func githubUser(user: String) -> AnyPublisher<GitHubResponse, GitHubError> {
        return github(with: makeUserComponents(withUser: user))
    }
    

    private func github<T>(with components: URLComponents) -> AnyPublisher<T, GitHubError> where T: Decodable {
        guard let url = components.url else {
            let error = GitHubError.network(description: "Couldn't create URL")
            return Fail(error: error).eraseToAnyPublisher()
        }
        print("url",url.absoluteString)
        
        return session.dataTaskPublisher(for: URLRequest(url: url))
          .mapError { error in
            .network(description: error.localizedDescription)
          }
          .flatMap(maxPublishers: .max(1)) { pair in
            decode(pair.data)
          }
          .eraseToAnyPublisher()
    }
}

private extension GitHubFetcher {
    struct GitHubAPI {
        static let scheme = "https"
        static let host = "api.github.com"
        static let path = "/search"
    }
    
    
    func makeUserComponents(withUser user: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = GitHubAPI.scheme
        components.host = GitHubAPI.host
        components.path = GitHubAPI.path + "/users"
        
        components.queryItems = [
          URLQueryItem(name: "q", value: user)
        ]
        return components
    }
}
