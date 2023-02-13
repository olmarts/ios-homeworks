//
//  ProfileViewController.swift
//  Navigation
//
//  Created by user1 on 10.02.2023.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let profileHeaderView = ProfileHeaderView()
    
    private var someButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Hidden button", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.backgroundColor = .systemGray2
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        profileHeaderView.backgroundColor = .lightGray
        profileHeaderView.setupView()
        view.addSubview(profileHeaderView)
        view.addSubview(someButton)
        setConstraints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        profileHeaderView.frame = view.bounds
    }
    
    private func setConstraints() {
        profileHeaderView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileHeaderView.leftAnchor.constraint(equalTo: view.leftAnchor),
            profileHeaderView.rightAnchor.constraint(equalTo: view.rightAnchor),
            profileHeaderView.heightAnchor.constraint(greaterThanOrEqualToConstant: 220),
            
            someButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            someButton.rightAnchor.constraint(equalTo: view.rightAnchor),
            someButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ])
    }
    
    
}
