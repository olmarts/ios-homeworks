//
//  PostViewController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//
import UIKit

// Показывает конкретный один пост в ленте Feed
final class PostViewController: UIViewController {
    
    private var post: Post?
    
    init(post: Post? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        view.backgroundColor = .systemGray3
        makeItemBar()
    }
    
    private func makeItemBar() {
        let barItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(barItemAction))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func barItemAction() {
        present(InfoViewController(), animated: true)
    }
    
}

