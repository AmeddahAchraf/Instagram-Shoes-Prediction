//
//  PostViewModel.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 23/6/2021.
//

import UIKit


class PostViewModel {
    
    private let postModel: PostModel
    
    
    var userName: String {
        return postModel.user.username
    }

    var caption: String {
        return postModel.caption
    }
    
    var imageURL: String {
        return postModel.imageUrl
    }

    init(postModel: PostModel) {
        self.postModel = postModel
    }
}


extension PostViewModel {
    private func loadImage(from url: String, _ completion: @escaping ((Result<UIImage, Error>) -> ())) {
        if let url = URL(string: url) {
            DispatchQueue.global().sync {
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        completion(.success(image))
                    }
                }
            }
        }
    }
    
    
}
