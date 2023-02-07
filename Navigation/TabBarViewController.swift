//
//  TabBarController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

/*
 3. В AppDelegate.swift добавьте UITabBarController.
 Добавьте в него два UINavigationController. Первый будет показывать ленту пользователя, а второй — профиль.
 4. Измените Tab Bar Item у добавленных контроллеров, добавьте заголовок и картинку.
 Картинки можно добавить в Assets.xcassets или использовать SF Symbols.
 */

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
        feedVC.tabBarItem.image = UIImage(systemName: "leaf.fill")
        profileVC.tabBarItem.title = "Profile"
        profileVC.tabBarItem.image = UIImage(systemName: "bolt.fill")
        /* 5. Создайте FeedViewController и ProfileViewController и добавьте их как root view controller у навигационных контроллеров.*/
        let navigationFeedVC = UINavigationController(rootViewController: feedVC)
        let navigationProfileVC = UINavigationController(rootViewController: profileVC)
        viewControllers = [navigationFeedVC, navigationProfileVC]
    }
 

}

