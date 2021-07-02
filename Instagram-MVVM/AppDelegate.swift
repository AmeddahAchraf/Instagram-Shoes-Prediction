//
//  AppDelegate.swift
//  Instagram-MVVM
//
//  Created by Achraf Ameddah on 13/6/2021.
//


import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainTabBarController()
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()
        FirebaseApp.configure()
        return true
    }
}


