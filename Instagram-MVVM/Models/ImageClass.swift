//
//  ImageClass.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 22/6/2021.
//

import Foundation

struct ImageClass: Decodable {
    public enum CodingKeys: String, CodingKey {
        case title
        case description
        case price
        case link
        case confidence
    }
    
    let title: String
    let description: String
    let price: String
    let link: String
    let confidence: Double
}
