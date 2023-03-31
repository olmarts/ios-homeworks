import UIKit

final class FeedViewController: UIViewController {
    
    private let posts: [Post] = PostsStore.shared.posts
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var showPostButton: UIButton = {
        let button = UIButton(frame: Metric.buttonRect)
        button.setTitle("Show randomized post", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Metric.buttonCornerRadius
        button.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(frame: Metric.buttonRect)
        button.setTitle(AppState.User.isAuthorized ? "Logout" : "Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Metric.buttonCornerRadius
        button.addTarget(self, action: #selector(logoutAction), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        setup()
    }
    
    private func setup() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(showPostButton)
        stackView.addArrangedSubview(logoutButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metric.inset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.inset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metric.inset),
        ])
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("userDidLogon"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: NSNotification.Name("userDidLogout"), object: nil)
    }
    
    @objc func reload() {
        logoutButton.setTitle(AppState.User.isAuthorized ? "Logout" : "Login", for: .normal)
    }
    
    @objc func showPostAction() {
        let postVC = PostViewController()
        postVC.model = posts.randomElement()
        navigationController?.pushViewController(postVC, animated: true)
    }
    
    @objc private func logoutAction() {
        NotificationCenter.default.post(name: NSNotification.Name("userDidLogout"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension FeedViewController {
    
    private enum Metric {
        static let inset: CGFloat = 16
        static let buttonRect: CGRect = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 150, height: 40))
        static let buttonCornerRadius: CGFloat = 10
    }
}
