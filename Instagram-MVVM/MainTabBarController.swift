//
//  ViewController.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello")
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        //home
        let layout = UICollectionViewFlowLayout ()
        layout.minimumLineSpacing = 0
        let homeNavController = templateNavController(unselectedImage: UIImage(systemName: "house")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "house.fill")!.withTintColor(.label, renderingMode: .alwaysOriginal), rootViewController: HomeViewController())
        //search
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let searchNavController = templateNavController(unselectedImage: UIImage(systemName: "magnifyingglass")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "magnifyingglass", withConfiguration: config)!.withTintColor(.label, renderingMode: .alwaysOriginal), rootViewController: ViewController())
        
        let plusNavController = templateNavController(unselectedImage: UIImage(systemName: "plus.square")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "plus.square")!.withTintColor(.label, renderingMode: .alwaysOriginal))
        
        let likeNavController = templateNavController(unselectedImage: UIImage(systemName: "heart")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "heart.fill")!.withTintColor(.label, renderingMode: .alwaysOriginal),rootViewController: ViewController())
        //user profile
        let userProfileNavController = templateNavController(unselectedImage: UIImage(systemName: "person")!.withTintColor(.label, renderingMode: .alwaysOriginal), selectedImage: UIImage(systemName: "person.fill")!.withTintColor(.label, renderingMode: .alwaysOriginal), rootViewController: ViewController())
        
        tabBar.tintColor = .black
        
        viewControllers = [homeNavController, searchNavController, plusNavController, likeNavController, userProfileNavController]
    }
    
    private func templateNavController(unselectedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController = UIViewController()) -> UINavigationController {
        let viewController = rootViewController
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        return navController
    }


}


class ViewController: UIViewController {
    
}
