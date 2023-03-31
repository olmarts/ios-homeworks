import UIKit

final class MainTabBarController: UITabBarController {
    
    let navigationFeedVC: UINavigationController = {
        let vc = FeedViewController()
        vc.tabBarItem.title = "Feed"
        vc.tabBarItem.image = UIImage(systemName: "house.fill")
        return UINavigationController(rootViewController: vc)
    }()
    
    let navigationLoginVC: UINavigationController = {
        let vc = LogInViewController()
        vc.tabBarItem.title = "Login"
        vc.tabBarItem.image = UIImage(systemName: "person.badge.clock.fill")
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    let navigationProfileVC: UINavigationController = {
        let vc = ProfileViewController()
        vc.tabBarItem.title = "Profile"
        vc.tabBarItem.image = UIImage(systemName: "person.fill")
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isHidden = true
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(login), name: NSNotification.Name("userDidLogon"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name("userDidLogout"), object: nil)
        needLoginControllers()
    }
    
    private func defaultControllers() {
        viewControllers = [navigationFeedVC, navigationProfileVC]
    }
    
    private func needLoginControllers() {
        viewControllers = [navigationFeedVC, navigationLoginVC]
    }
    
    @objc private func login(_ notification: Notification? = nil) {
        guard let notification = notification,
              let userInfo = notification.userInfo,
              let username = userInfo["username"] as? String,
              let password = userInfo["password"] as? String
        else { return }
        if username.count >= 0 && password.count >= 0 {
            print("User '\(username)':'\(password)' is logon: \(Date())")
            AppState.User.isAuthorized = true
            defaultControllers()
            self.selectedIndex = self.viewControllers?.firstIndex(where: { $0 == navigationProfileVC }) ?? 0
        } else {
            print(#function, "error")
        }
    }
    
    @objc private func logout() {
        print("User is logout: \(Date())")
        AppState.User.isAuthorized = false
        needLoginControllers()
        self.selectedIndex = self.viewControllers?.firstIndex(where: { $0 == navigationLoginVC }) ?? 0
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

