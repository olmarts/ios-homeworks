//
//  TabBarController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

import UIKit

// Плоский нижний навигатор
final class TabBarViewController: UITabBarController {

    private let feedVC = FeedViewController()
    private let profileVC = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray5
        setupControllers()
    }
    
    private func setupControllers() {
        feedVC.tabBarItem.title = "Feed"
        feedVC.tabBarItem.image = UIImage(systemName: "house.fill")
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "person.fill")
        
        let navigationFeedVC = UINavigationController(rootViewController: feedVC)
        let navigationProfileVC = UINavigationController(rootViewController: profileVC)
        viewControllers = [navigationFeedVC, navigationProfileVC]
    }
 

}

