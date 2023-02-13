//
//  FeedViewController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

import UIKit

// Показывает ленту постов
final class FeedViewController: UIViewController {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()
    
    
    private let showPostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50 , y: 50, width: 150, height: 40))
        button.setTitle("Show post", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    private let editPostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50 , y: 50, width: 150, height: 40))
        button.setTitle("Edit post", for: .normal)
        button.backgroundColor = .systemBlue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        layout()
        setupButtons()
    }
    
    private func layout() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(showPostButton)
        stackView.addArrangedSubview(editPostButton)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    private func setupButtons() {
        showPostButton.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
        editPostButton.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
    }
    
    @objc func showPostAction() {
        // postId - просто эмулятор уникального идентификатора просматриваемого поста:
        let postId = Int.random(in: 1000..<10000)
        let post = Post(title: "Post#\(postId)")
        
        let postVC = PostViewController(post: post)
        postVC.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    
}

