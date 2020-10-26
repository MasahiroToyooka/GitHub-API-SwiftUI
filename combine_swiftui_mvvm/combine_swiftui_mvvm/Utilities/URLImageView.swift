//
//  URLImageView.swift
//  combine_swiftui_mvvm
//
//  Created by 豊岡正紘 on 2020/10/20.
//  Copyright © 2020 Masahiro Toyooka. All rights reserved.
//

import SwiftUI

import SwiftUI

struct URLImageView: View {
    
    @ObservedObject var viewModel: URLImageViewModel
    
    var body: some View {
        if let imageData = self.viewModel.downloadData {
            if let image = UIImage(data: imageData) {
                return Image(uiImage: image).resizable()
            } else {
                return Image(uiImage: UIImage()).resizable()
            }
        } else {
            return Image(uiImage: UIImage()).resizable()
        }
    }
}

final class URLImageViewModel: ObservableObject {
    
    @Published var downloadData: Data? = nil
    let url: String
    
    init(url: String, isSync: Bool = false) {
        self.url = url
        if isSync {
            self.downloadImageSync(url: self.url)
        } else {
            self.downloadImageAsync(url: self.url)
        }
    }
    
    func downloadImageAsync(url: String) {
        
        guard let imageURL = URL(string: url) else { return }
                
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.downloadData = data
            }
        }
    }
    
    func downloadImageSync(url: String) {
        
        guard let imageURL = URL(string: url) else { return }
        
        let data = try? Data(contentsOf: imageURL)
        self.downloadData = data
    }
}
