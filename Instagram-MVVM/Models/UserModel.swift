//
//  UserModel.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 14/6/2021.
//

import Foundation

struct UserModel: Decodable {
    private enum CodingKeys: String, CodingKey {
        case bio
        case followersCount
        case followingCount
        case postsCount
        case profileImageUrl
        case userId
        case username
    }
    let bio: String
    let followersCount: Int
    let followingCount: Int
    let postsCount: Int
    let profileImageUrl: String
    let userId: String
    let username: String
}
