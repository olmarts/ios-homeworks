//
//  InfoViewController.swift
//  Navigation
//
//  Created by user1 on 06.02.2023.
//

/* 9. На InfoViewController создайте кнопку.
 При нажатии на неё должен показаться UIAlertController с заданным title, message и двумя UIAlertAction.
 При нажатии на UIAlertAction в консоль должно выводиться сообщение.
 */

import UIKit

// Показывает какую-то инфу текущего поста
final class InfoViewController: UIViewController {

    private let backButton: UIButton = {
        let button: UIButton = UIButton(frame: CGRect(x: 50 , y: 50, width: 150, height: 40))
        button.setTitle("Назад", for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray2
        setupButton()
    }
    
    private func setupButton() {
        self.view.addSubview(backButton)
        backButton.center = self.view.center
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
    }
    
    @objc private func backAction() {
        // при нажатии кнопки модально покажем окно с алертами:
        let alert = UIAlertController(title: "Вернуться к посту", message: "Вы уверены?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Да", style: .default, handler:  { _ in
            // закрыть это модальное окно и сообщить в консоль:
            self.dismiss(animated: true)
            print("- \(#function): подтверждено")
        })
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive, handler: {_ in
            // просто сообщить в консоль:
            print("- \(#function): отменено")
        })
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}

