import UIKit

final class PostTableViewCell: UITableViewCell {
    
    private let imgView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    private let authorText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .darkText
        return label
    }()
    
    private let descriptionText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .justified
        label.textColor = UIColor(hex: "#565656")
        return label
    }()
    
    private let likesText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = UIColor(hex: "#747474")
        return label
    }()
    
    private let viewsText: UILabel = {
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
    
    func setupCell(model: Post) -> PostTableViewCell {
        authorText.text = model.author
        imgView.image = UIImage(named: model.image)
        descriptionText.text = model.description
        likesText.text = "Likes: \(model.likes)"
        viewsText.text = "Viewa: \(model.views)"
        return self
    }
    
    private func layout() {
        [authorText, imgView, descriptionText, likesText, viewsText].forEach { contentView.addSubview($0) }
        contentView.layer.borderWidth = 0
        
        let inset: CGFloat = 16
        let imageHeight: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - (inset*2)
        
        NSLayoutConstraint.activate([
            authorText.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            authorText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            authorText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            /* обе вертикальные границы картинки выводим за экран, чтобы показать только
             горизонтальные границы (актуально для картинок со светлым непрозрачным фоном). */
            imgView.topAnchor.constraint(equalTo: authorText.bottomAnchor, constant: inset),
            imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: -0.5),
            imgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0.5),
            imgView.heightAnchor.constraint(equalToConstant: imageHeight),
            
            descriptionText.topAnchor.constraint(equalTo: imgView.bottomAnchor, constant: inset),
            descriptionText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            descriptionText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            
            likesText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: inset),
            likesText.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            likesText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
            
            viewsText.topAnchor.constraint(equalTo: descriptionText.bottomAnchor, constant: inset),
            viewsText.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            viewsText.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset),
        ])
    }
    
}
