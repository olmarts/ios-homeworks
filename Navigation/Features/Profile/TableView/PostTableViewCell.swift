import UIKit

final class PostTableViewCell: UITableViewCell {
    
    var postDetailsCallback: Optional<(Post)->Void> = nil
    
    private var model: Post? = nil
    
    private lazy var postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .systemGray
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showPostDetails)))
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .darkText
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 3
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .justified
        label.textColor = UIColor(hex: "#565656")
        return label
    }()
    
    private lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(hex: "#747474")
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(likeAction)))
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(hex: "#747474")
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [authorLabel, postImage, descriptionLabel, likesLabel, viewsLabel].forEach { contentView.addSubview($0) }
        contentView.layer.borderWidth = 0
        let imageHeight: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - (Metric.inset*2)
        
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metric.inset),
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
    
    func setupCell(model: Post) {
        self.model = model
        bindModel()
    }
    
    private func bindModel() {
        if let post = model {
            authorLabel.text = post.author
            postImage.image = UIImage(named: post.image)
            descriptionLabel.text = post.description
            likesLabel.text = "Likes: \(post.likes)"
            viewsLabel.text = "Viewa: \(post.views)"
        }
    }
    
    @objc private func likeAction() {
        model?.likes += 1
        likesLabel.animatePressEffect()
        PostsStore.shared.save()
        bindModel()
    }
    
    @objc private func showPostDetails() {
        if let post = model {
            postDetailsCallback?(post)
        }
    }
}

extension PostTableViewCell {
    
    private enum Metric {
        static let inset: CGFloat = 16
    }
}

