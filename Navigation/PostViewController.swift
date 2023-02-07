//
//  PostViewController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

/* 6. Добавьте PostViewController для показа выбранного поста.
 Поменяйте заголовок у контроллера и цвет главной view.
 Добавьте кнопку на FeedViewController и сделайте переход на экран поста.
 Контроллер должен показаться в стеке UINavigationController.
 
 8. На PostViewController добавьте Bar Button Item в навигейшн бар.
 При нажатии на него должен открываться новый контроллер InfoViewController.
 Контроллер должен показаться модально.
 */
import UIKit

// Показывает конкретный один пост в ленте Feed
final class PostViewController: UIViewController {

    private var post: Post?

    // инициализатор с optional-параметром типа Post:
    init(post: Post? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.post = post
    }

    // этот метод требует протокол. так как у нас свой инициализатор
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
        // создаем и настраиваем элемент UIBarButtonItem:
        let barItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(barItemAction))
        navigationItem.rightBarButtonItem = barItem
    }

    @objc private func barItemAction() {
        // модально показываем окно Info:
        let infoVC = InfoViewController()
        present(infoVC, animated: true)
    }

}

