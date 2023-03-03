import UIKit

final class PhotosTableViewCell: UITableViewCell {
    
    // функция назначается контроллером, в котором определен UITableView:
    var showPhotoGallery: ((Int) -> Void)? = nil
    
    private let model: [UIImage] = Photos.makeMockModel(maxCount: 4)
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Photos"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let galleryButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "arrow.forward"), for: .normal)
        return button
    }()
    
    private var collectionViewHeight: CGFloat = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = Metric.cellSpacing
        let rowWidth = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height) - Metric.inset*2
        let cellWidth = layout.calcCellWidth(rowWidth: rowWidth, cellSpacing: Metric.cellSpacing, cellsInRow: Metric.cellsInRow)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth * 1.0)
        self.collectionViewHeight = layout.itemSize.height
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self,  forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // установить isUserInteractionEnabled именно ДО addSubview(..) чтобы включились все addTarget из ячейки таблицы:
        contentView.isUserInteractionEnabled = true
        
        galleryButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        [titleLabel, galleryButton, collectionView].forEach({ addSubview($0) })
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: Metric.inset),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.inset),
            
            galleryButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            galleryButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metric.inset),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Metric.inset),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metric.inset),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metric.inset),
            collectionView.heightAnchor.constraint(equalToConstant: collectionViewHeight),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Metric.inset),
            
        ])
    }
    
    @objc private func buttonPressed() {
        if let action = self.showPhotoGallery { action(-1) }
    }
    
}

extension PhotosTableViewCell {
    
    private enum Metric {
        static let cellsInRow: CGFloat = 4
        static let cellSpacing: CGFloat = 8
        static let inset: CGFloat = 12
    }
    
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setImage(image: self.model[indexPath.row], cornerRadius: 6)
        return cell
    }
    
}

extension PhotosTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // покажем галерею с выделенной фоткой:
        if let action = self.showPhotoGallery { action(indexPath.row) }
    }
    
}
