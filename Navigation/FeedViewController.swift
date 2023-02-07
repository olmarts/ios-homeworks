//
//  FeedViewController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

/*
5.1. Создайте FeedViewController и ProfileViewController.
 
 */

import UIKit

// Показывает ленту постов
final class FeedViewController: UIViewController {
    
    
    private let showPostButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 50 , y: 50, width: 150, height: 40))
        button.setTitle("Show post", for: .normal)
        button.backgroundColor = .blue
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        setupButton()
    }

    private func setupButton() {
        view.addSubview(showPostButton)
        showPostButton.center = view.center
        showPostButton.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
    }

    @objc func showPostAction() {
        /* 7.2. Создайте объект типа Post в FeedViewController и передайте его в PostViewController. В классе PostViewController выставьте title полученного поста в качестве заголовка контроллера.*/
        // postId - просто эмулятор уникального идентификатора просматриваемого поста:
        let postId = Int.random(in: 1000..<10000)
        let post = Post(title: "Post#\(postId)")
        // показываем (пушим) это пост:
        let postVC = PostViewController(post: post)
        postVC.title = post.title
        navigationController?.pushViewController(postVC, animated: true)
    }
    
}

