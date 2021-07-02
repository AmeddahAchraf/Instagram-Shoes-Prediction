//
//  PostModel.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 14/6/2021.
//

import Foundation

struct PostModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case imageUrl
        case caption
        case creationDate
        case hasLiked
        case user
    }

    var user: UserModel
    var imageUrl: String
    var caption: String
    var creationDate: Date
    var hasLiked: Bool
}
