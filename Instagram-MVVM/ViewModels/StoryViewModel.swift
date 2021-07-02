//
//  StoryViewModel.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 23/6/2021.
//

import UIKit

class StoryViewModel {
    
    private let storyModel: StoryModel
    
    var storyImage: UIImage {
        return storyModel.storyImage
    }
    var storyLabel: String {
        return storyModel.storyLabel
    }

    init(storyModel: StoryModel) {
        self.storyModel = storyModel
    }
}
