//
//  ProfileViewController.swift
//  Navigation
//
//  Created by user1 on 10.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    // Внешняя функция, котора] будет выполнена после Logout:
    var afterLogoutAction: Optional<() -> ()> = nil
    
    let profileHeaderView = ProfileHeaderView()
    
    private var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.lightText, for: .normal)
        button.backgroundColor = .systemBlue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        profileHeaderView.backgroundColor = .lightGray
        profileHeaderView.setupView()
        view.addSubview(profileHeaderView)
        view.addSubview(logoutButton)
        logoutButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.bounds
    }
    
    
    @objc private func buttonPressed() {
        if let externalFunc = self.afterLogoutAction {
            externalFunc()
            print("Log out!")
        }
    }
    
    private func setConstraints() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),
            
            logoutButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            logoutButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            logoutButton.heightAnchor.constraint(equalToConstant: 50),
            logoutButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    
}
