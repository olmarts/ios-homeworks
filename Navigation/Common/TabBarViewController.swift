//
//  TabBarController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

import UIKit

// Плоский нижний навигатор
final class TabBarViewController: UITabBarController {

    
    private let navigationFeedVC: UINavigationController = {
        let vc = FeedViewController()
        vc.tabBarItem.title = "Feed"
        vc.tabBarItem.image = UIImage(systemName: "house")
        return UINavigationController(rootViewController: vc)
    }()
    
    private lazy var navigationLoginVC: UINavigationController = {
        let vc = LogInViewController()
        vc.tabBarItem.title = "Profile"
        vc.tabBarItem.image = UIImage(systemName: "person.badge.clock")
        vc.afterLogonAction = self.showProfile
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    private lazy var navigationProfileVC: UINavigationController = {
        let vc = ProfileViewController()
        vc.tabBarItem.title = "Profile"
        vc.tabBarItem.image = UIImage(systemName: "person")
        vc.afterLogoutAction = self.showLogin
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = false
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [navigationFeedVC, navigationLoginVC]
    }
 
    func showProfile() {
        viewControllers = [navigationFeedVC, navigationProfileVC]
    }

    func showLogin() {
        viewControllers = [navigationFeedVC, navigationLoginVC]
    }
}

