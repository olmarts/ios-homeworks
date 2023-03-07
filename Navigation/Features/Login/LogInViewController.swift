import UIKit

final class LogInViewController: UIViewController {
    
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
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 1
        stackView.layer.cornerRadius = 10
        stackView.layer.borderWidth = 0.5
        stackView.layer.borderColor = UIColor.lightGray.cgColor
        return stackView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var userNameTextField: UITextField = {
        let textField = PaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.clearButtonMode = .whileEditing
        textField.placeholder = "Email or phone"
        textField.setPlaceholderColor(textField.textColor, alpha: 0.6)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(hex: "#4885CC")
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var userPasswordTextField: UITextField = {
        let textField = PaddingTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isSecureTextEntry = true
        textField.enableEyeButton(true, eyeColor: UIColor(hex: "#363636"))
        textField.placeholder = "Password"
        textField.setPlaceholderColor(textField.textColor, alpha: 0.6)
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.tintColor = UIColor(hex: "#4885CC")
        textField.autocapitalizationType = .none
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldEditingDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private let warningLabel: UILabel = {
        let label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textInsets = UIEdgeInsets(top: Metric.inset/2, left: Metric.inset, bottom: Metric.inset/2, right: Metric.inset)
        label.numberOfLines = 0
        label.backgroundColor = .systemYellow
        label.textColor = .red
        label.isHidden = true
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Log in (\(Metric.defaultUserName) \(Metric.defaultPassword))", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .selected)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .highlighted)
        button.setTitleColor(.white.withAlphaComponent(0.8), for: .disabled)
        button.setBackgroundImage(UIImage(named: "blue_pixel"), for: .normal)
        button.layer.cornerRadius = 10
        // скруглить углы у кнопки, покрашенной картинкой, получилось только вот так:
        button.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
        userNameTextField.text = nil
        userPasswordTextField.text = nil
        warningLabel.text = nil
        warningLabel.isHidden = true
        view.endEditing(true)
    }
    
    private func setup() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [logoImageView, stackView, warningLabel, loginButton].forEach({ contentView.addSubview($0) })
        [userNameTextField, separatorView, userPasswordTextField].forEach({ stackView.addArrangedSubview($0) })
        setConstraints()
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
            
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.logoTop),
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 60),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            stackView.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: -Metric.inset * 2),
            
            userNameTextField.heightAnchor.constraint(equalToConstant: Metric.textFieldHeight),
            separatorView.heightAnchor.constraint(equalToConstant: 0.5),
            userPasswordTextField.heightAnchor.constraint(equalToConstant: Metric.textFieldHeight),
            
            warningLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            warningLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            warningLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            
            loginButton.topAnchor.constraint(equalTo: warningLabel.bottomAnchor, constant: Metric.inset/2),
            loginButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            loginButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            loginButton.heightAnchor.constraint(equalToConstant: Metric.buttonHeight),
            loginButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset/2)
            
        ])
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
    
    @objc private func textFieldEditingDidChange(_ sender: Any?) {
        if sender is UITextField && warningLabel.isHidden == false {
            warningLabel.isHidden.toggle()
            warningLabel.text = nil
        }
    }
    
    @objc private func loginAction() {
        var userName = userNameTextField.text
        if validateUserName(userName: &userName) == false  { return }
        
        var password = userPasswordTextField.text
        // admin:
        if userName == Metric.defaultUserName && password == Metric.defaultPassword {
            NotificationCenter.default.post(name: NSNotification.Name("userDidLogon"), object: nil, userInfo: ["username": Metric.defaultUserName, "password": password!])
        } else {
            // another:
            if validatePassword(password: &password) == false { return }
            let alert = UIAlertController(title: "Ошибка входа", message: "Неверный логин или пароль", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
        view.endEditing(true)
    }
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            if validateUserName(userName: &userNameTextField.text) {
                userPasswordTextField.becomeFirstResponder()
            }
        } else if textField == userPasswordTextField {
            loginAction()
            return true
        }
        return false
    }
}

extension LogInViewController {
    
    private enum Metric {
        static let logoTop: CGFloat = 160
        static let textFieldHeight: CGFloat = 40
        static let buttonHeight: CGFloat = 50
        static let inset: CGFloat = 16
        static let minPasswordLenght: Int = 6
        static let defaultUserName: String = "admin"
        static let defaultPassword: String = "000000"
    }
    
    private func validateUserName(userName: inout String?) -> Bool {
        userName = userName?.trimmingCharacters(in: .whitespacesAndNewlines)
        if userName == Metric.defaultUserName { return true }
        do {
            return try Validator.isValidUsername(userName)
        }
        catch ValidationError.emptyValue { userNameTextField.animateShakeEffect() }
        catch ValidationError.username(let error) {
            warningLabel.text = error
            warningLabel.isHidden = false
            userNameTextField.animateShakeEffect()
        }
        catch { print(error) }
        return false
    }
    
    private func validatePassword(password: inout String?) -> Bool {
        password = password?.trimmingCharacters(in: .whitespacesAndNewlines)
        if password == Metric.defaultPassword { return true }
        do {
            return try Validator.isValidPassword(password, minLenght: Metric.minPasswordLenght)
        }
        catch ValidationError.emptyValue { userPasswordTextField.animateShakeEffect() }
        catch ValidationError.password(let errors) {
            warningLabel.text = errors.joined(separator: "\n")
            warningLabel.isHidden = false
            userPasswordTextField.animateShakeEffect()
        }
        catch { print(error) }
        return false
    }
}

