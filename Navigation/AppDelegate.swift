//
//  AppDelegate.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

/*
 3. В AppDelegate.swift добавьте UITabBarController.
 
 Проблема после выпиливания SceneDelegate:
 Если в симуляторе backgroundColor станет черным, то
 в Info.plist удалить ВСЮ ветку 'Scene Configuration'.
 */

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemGray4
        window?.rootViewController = TabBarViewController()
        window?.makeKeyAndVisible()
        return true
    }
}

