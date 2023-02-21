import UIKit

final class LogInViewController: UIViewController {
    
    // Внешняя функция, котора] будет выполнена после входа:
    var afterLogonAction: Optional<() -> ()> = nil
    
    // Уведомлять о появлении/скрытии клавиатуры:
    private let notification = NotificationCenter.default
    
    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let roundCornersView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Email or phone"
        textField.placeholderColor(textField.textColor, alpha: 0.6)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(hex: "#4885CC")
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.setPadding(left: 16, right: 16)
        return textField
    }()
    
    private lazy var userPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.placeholderColor(textField.textColor, alpha: 0.6)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(hex: "#4885CC")
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.setPadding(left: 16, right: 16)
        return textField
    }()
    
    private var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        // скруглить углы у кнопки, покрашенной картинкой, получилось только вот так:
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        button.layer.masksToBounds = true
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImageView, roundCornersView].forEach({ contentView.addSubview($0) })
        [userNameTextField, separatorView, userPasswordTextField].forEach({ roundCornersView.addSubview($0) })
        contentView.addSubview(loginButton)
        setConstraints()
        loginButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        notification.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        notification.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        notification.removeObserver(UIResponder.keyboardWillShowNotification)
        notification.removeObserver(UIResponder.keyboardWillHideNotification)
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keybordSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keybordSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keybordSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide() {
        scrollView.contentInset = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
    
    @objc private func buttonPressed() -> Bool {
        if let username = userNameTextField.text, let password = userPasswordTextField.text {
            print("User '\(username):\(password)' is logged in")
        }
        userNameTextField.text = nil
        userPasswordTextField.text = nil
        if let externalFunc = self.afterLogonAction  { externalFunc() }
        return textFieldShouldReturn(userPasswordTextField)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 160),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            roundCornersView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            roundCornersView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            roundCornersView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            roundCornersView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -32),
            
            userNameTextField.topAnchor.constraint(equalTo: roundCornersView.topAnchor),
            userNameTextField.leadingAnchor.constraint(equalTo: roundCornersView.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: roundCornersView.trailingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            separatorView.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: roundCornersView.leadingAnchor),
            separatorView.trailingAnchor.constraint(equalTo: roundCornersView.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            
            userPasswordTextField.topAnchor.constraint(equalTo: separatorView.bottomAnchor),
            userPasswordTextField.leadingAnchor.constraint(equalTo: roundCornersView.leadingAnchor),
            userPasswordTextField.trailingAnchor.constraint(equalTo: roundCornersView.trailingAnchor),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            userPasswordTextField.bottomAnchor.constraint(equalTo: roundCornersView.bottomAnchor),
            
            loginButton.topAnchor.constraint(equalTo: roundCornersView.bottomAnchor, constant: 8),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
            
        ])
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
}

