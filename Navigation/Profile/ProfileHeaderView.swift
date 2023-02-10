//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by user1 on 10.02.2023.
//

import UIKit

final class ProfileHeaderView: UIView {
    
    private var statusText = String()
    
    private var userImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 130, height: 130))
        imageView.image = UIImage(imageLiteralResourceName: "png-cat")
        imageView.layer.cornerRadius = imageView.frame.width/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hipster Cat"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let userStatusLabel: UILabel = {
        let label = UILabel()
        label.text = "Listening to music"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Listening to music"
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.backgroundColor = .white
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private var setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupView() {
        addSubview(userImageView)
        addSubview(userNameLabel)
        addSubview(userStatusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
        setConstraints()
        setStatusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
    }
    
    @objc private func buttonPressed(){
        if (!statusText.isEmpty) {
            userStatusLabel.text = statusText
        }
        print("status: '\(statusText)'")
    }
    
    @objc func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text!
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            userImageView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 130),
            userImageView.heightAnchor.constraint(equalToConstant: 130),
            
            userNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 16),
            userNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            userStatusLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 16),
            userStatusLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 16),
            userStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            statusTextField.topAnchor.constraint(equalTo: userStatusLabel.bottomAnchor, constant: 8),
            statusTextField.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 16),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 16),
            setStatusButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
}