//
//  HomeViewModel.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/16.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var dataSource: [UserRowViewModel] = []

    
    private let githubFetcher: GitHubFetcher
    private var disposables = Set<AnyCancellable>()

    init(
        githubFetcher: GitHubFetcher,
        scheduler: DispatchQueue = DispatchQueue(label: "HomeViewModel")
    ) {

        self.githubFetcher = githubFetcher

        $searchText
            .filter { !$0.isEmpty }
            .debounce(for: .seconds(0.5), scheduler: scheduler)
            .sink(receiveValue: { _ in self.fetchGitHubUser(text: self.searchText) })
            .store(in: &disposables)

    }

    func fetchGitHubUser(text: String) {
        githubFetcher.githubUser(user: text)
            .map { response in
                response.items.map(UserRowViewModel.init)
            }
            .receive(on: DispatchQueue.main)
            .sink(
              receiveCompletion: { [weak self] value in
                guard let self = self else { return }
                switch value {
                case .failure:
                  self.dataSource = []
                case .finished:
                  break
                }
              },
              receiveValue: { [weak self] items in
                guard let self = self else { return }
                self.dataSource = items
                
                print(items)
            })
            .store(in: &disposables)
    }
    
    
//    init(githubFetcher: GitHubFetcher, scheduler: DispatchQueue = DispatchQueue(label: "HomeViewModel")) {
//
//        self.githubFetcher = githubFetcher
//
//        let _fetchUser = PassthroughSubject<String, Never>()
//
//        $searchText
//            .filter { !$0.isEmpty }
//            .debounce(for: .seconds(0.5), scheduler: scheduler)
//            .sink(receiveValue: { _fetchUser.send($0) })
//            .store(in: &disposables)
//
//
//        _fetchUser
//            .map { user -> AnyPublisher<Result<[UserRowViewModel], GitHubError>, Never> in
//                githubFetcher.githubUser(user: user)
//                    .prefix(1)
//                    .map { Result.success(Array.removeDuplicates($0.items.map(UserRowViewModel.init)))}
//                    .catch { Just(Result.failure($0)) }
//                    .eraseToAnyPublisher()
//            }
//            .switchToLatest()
//            .receive(on: DispatchQueue.main)
//            .sink(receiveValue: { [weak self] result in
//                guard let self = self else { return }
//                switch result {
//                case let .success(user):
//                    self.dataSource = user
//                case .failure:
//                    self.dataSource = []
//                }
//            })
//            .store(in: &disposables)
//    }
//
//}
//
//
//public extension Array where Element: Hashable {
//  static func removeDuplicates(_ elements: [Element]) -> [Element] {
//    var seen = Set<Element>()
//    return elements.filter{ seen.insert($0).inserted }
//  }
//}
}
