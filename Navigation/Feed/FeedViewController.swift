import UIKit

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
        let button = UIButton(frame: Metric.buttonRect)
        button.setTitle("Show post", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Metric.buttonCornerRadius
        return button
    }()
    
    private let editPostButton: UIButton = {
        let button = UIButton(frame: Metric.buttonRect)
        button.setTitle("Edit post", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = Metric.buttonCornerRadius
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
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metric.inset),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Metric.inset),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Metric.inset),
        ])
    }
    
    private func setupButtons() {
        showPostButton.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
        editPostButton.addTarget(self, action: #selector(showPostAction), for: .touchUpInside)
    }
    
    @objc func showPostAction() {
        let post = Post.makeMockModel().first
        let postVC = PostViewController(post: post)
        postVC.title = post?.author
        navigationController?.pushViewController(postVC, animated: true)
    }
    
}

extension FeedViewController {
    
    private enum Metric {
        static let inset: CGFloat = 16
        static let buttonRect: CGRect = CGRect(origin: CGPoint(x: 50, y: 50), size: CGSize(width: 150, height: 40))
        static let buttonCornerRadius: CGFloat = 10
    }
    
}
