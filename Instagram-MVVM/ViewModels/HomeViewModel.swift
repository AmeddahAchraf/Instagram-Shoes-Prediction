//
//  HomeViewModel.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

enum HomeViewModel {
    case storyCollectionView(models: [StoryViewModel], rows: Int)
    case posts(models: [PostViewModel])
}
