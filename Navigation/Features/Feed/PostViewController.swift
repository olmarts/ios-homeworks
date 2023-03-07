import UIKit

final class PostViewController: UIViewController {
    
    var model: Post? = nil {
        didSet {
            incrementViews()
        }
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = .darkText
        return label
    }()
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .systemGray
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .justified
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(hex: "#414141")
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeAction)))
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(hex: "#414141")
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        if !self.isModal() {
            makeItemBar()
            closeButton.isHidden = true
            authorLabel.isHidden = true
            authorLabel.text = nil
        }
        
        view.backgroundColor = .systemGray4
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [closeButton, authorLabel, postImage, descriptionLabel, likesLabel, viewsLabel].forEach({ contentView.addSubview($0) })
        
        let imageHeight: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - (Metric.inset*2)
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -Metric.inset),
            
            closeButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            closeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            authorLabel.topAnchor.constraint(equalTo:  self.isModal() ? closeButton.bottomAnchor : contentView.topAnchor),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            
            postImage.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: Metric.inset),
            postImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -0.5),
            postImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.5),
            postImage.heightAnchor.constraint(equalToConstant: imageHeight),
            
            descriptionLabel.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: Metric.inset),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metric.inset),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metric.inset),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),
            
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Metric.inset),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metric.inset),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metric.inset),
        ])
    }
    
    private func bindModel() {
        if let post = model {
            title = post.author
            authorLabel.text = post.author
            postImage.image = UIImage(named: post.image)
            descriptionLabel.text = post.description
            likesLabel.text = "Likes: \(post.likes)"
            viewsLabel.text = "Viewa: \(post.views)"
        }
    }

    private func incrementViews() {
        if let post = model {
            post.views += 1
            PostsStore.shared.save()
            bindModel()
        }
    }
    
    @objc private func likeAction() {
        if let post = model {
            likesLabel.animatePressEffect()
            post.likes += 1
            PostsStore.shared.save()
            bindModel()
        }
    }
    
    @objc private func closeAction() {
        self.dismiss(animated: true)
    }
}

extension PostViewController {
    
    private enum Metric {
        static let inset: CGFloat = 16
    }
}

extension PostViewController {

    private func makeItemBar() {
        let barItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(barItemAction))
        navigationItem.rightBarButtonItem = barItem
    }
    
    @objc private func barItemAction() {
        present(InfoViewController(), animated: true)
    }
    
}

