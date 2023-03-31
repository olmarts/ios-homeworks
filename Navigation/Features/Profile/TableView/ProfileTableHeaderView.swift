import UIKit

final class ProfileTableHeaderView: UIView {
    
    private let defaultStatusText = "Listening to music"
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: Metric.avatarWidth, height: Metric.avararHeight))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "png-cat")
        imageView.layer.cornerRadius = Metric.avatarWidth/2
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapImageAction)))
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hipster Cat"
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private lazy var userStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = defaultStatusText
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .darkGray
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        return label
    }()
    
    private lazy var statusTextField: UITextField = {
        let textField = PaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.placeholder = defaultStatusText
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.backgroundColor = .white
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1.0
        textField.layer.borderColor = UIColor.black.cgColor
        textField.delegate = self
        return textField
    }()
    
    private lazy var setStatusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.setTitle("Set status", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        button.layer.shadowOffset = CGSize(width: 4, height: 4)
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.addTarget(self, action: #selector(setStatusAction), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .systemGray3
        [userImageView, userNameLabel, userStatusLabel, statusTextField, setStatusButton].forEach({ addSubview($0) })
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Metric.inset),
            userImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Metric.inset),
            userImageView.widthAnchor.constraint(equalToConstant: Metric.avatarWidth),
            userImageView.heightAnchor.constraint(equalToConstant: Metric.avararHeight),
            
            userNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 27),
            userNameLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Metric.avatarWidth + Metric.inset * 2),
            userNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Metric.inset),
            
            userStatusLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: Metric.inset),
            userStatusLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Metric.avatarWidth + Metric.inset * 2),
            userStatusLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Metric.inset),
            
            statusTextField.topAnchor.constraint(greaterThanOrEqualTo: userStatusLabel.bottomAnchor, constant: Metric.inset/2),
            statusTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Metric.avatarWidth + Metric.inset * 2),
            statusTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Metric.inset),
            statusTextField.heightAnchor.constraint(equalToConstant: 40),
            
            setStatusButton.topAnchor.constraint(greaterThanOrEqualTo: userImageView.bottomAnchor, constant: Metric.inset),
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: Metric.inset),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Metric.inset),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Metric.inset),
            setStatusButton.heightAnchor.constraint(equalToConstant: 50),
            setStatusButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metric.inset + setStatusButton.layer.shadowOffset.height),
        ])
    }
    
    @objc private func setStatusAction() {
        guard let statusText = statusTextField.text?.trimmingCharacters(in: .whitespaces) else { return }
        if statusText.count == 0 {
            statusTextField.animateShakeEffect()
            return
        }
        userStatusLabel.text = statusText
        statusTextField.text = nil
        self.endEditing(true)
    }
    
    @objc private func tapImageAction() {
        let glassView = ProfileAnimationView(originalView: userImageView)
        addSubview(glassView)
        glassView.animateView()
    }
}

extension ProfileTableHeaderView {
    
    private enum Metric {
        static let avatarWidth: CGFloat = 100
        static let avararHeight: CGFloat = 100
        static let inset: CGFloat = 16
    }
    
}

extension ProfileTableHeaderView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        endEditing(true)
        return true
    }
    
}
