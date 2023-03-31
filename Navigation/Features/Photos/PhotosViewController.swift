import UIKit

final class PhotosViewController: UIViewController {
    
    private let model: [UIImage] = Photos.makeMockModel(maxCount: 24)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let rowWidth = min(view.bounds.width, view.bounds.height) - Metric.inset*2
        let cellWidth = layout.calcCellWidth(rowWidth: rowWidth, cellSpacing: Metric.cellSpacing, cellsInRow: Metric.cellsInRow)
        layout.minimumInteritemSpacing = Metric.cellSpacing
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self,  forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()
    
    private var selectedCell: UICollectionViewCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setup() {
        title = "Photo Gallery"
        view.backgroundColor = .systemGray4
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metric.inset),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Metric.inset),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Metric.inset),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Metric.inset),
        ])
        NotificationCenter.default.addObserver(self, selector: #selector(hideSelectedCell), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    func selectPhoto(image: UIImage?) {
        if let image = image, let imageIndex = model.firstIndex(of: image) {
            collectionView.selectItem(at: IndexPath(item: imageIndex, section: 0), animated: true, scrollPosition: .centeredVertically)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
}

extension PhotosViewController {
    
    private enum Metric {
        static let cellsInRow: CGFloat = 3
        static let cellSpacing: CGFloat = 8
        static let inset: CGFloat = 8
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotosCollectionViewCell.identifier, for: indexPath) as! PhotosCollectionViewCell
        cell.setImage(image: self.model[indexPath.row])
        return cell
    }
    
}

extension PhotosViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) {
            self.selectedCell = cell
            showSelectedCell(image: model[indexPath.row])
        }
    }
}


/// Два метода анимации картинки из выбранной ячейки коллекции. Используются динамические UI-элементы.
extension PhotosViewController {
    
    /// Анимация  от  позиции selected-ячейки коллекции.
    private func showSelectedCell(image: UIImage) {
        guard let cell = self.selectedCell else { return }
        
        let glassView = UIView(frame: UIScreen.main.bounds)
        view.addSubview(glassView)
        view.bringSubviewToFront(glassView)
        
        let closeButton: UIButton = {
            let button = UIButton(type: .close)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.backgroundColor = .systemGray
            button.alpha = 0
            button.tintColor = .black
            button.addTarget(self, action: #selector(hideSelectedCell), for: .touchUpInside)
            return button
        }()
        glassView.addSubview(closeButton)
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let imageView: UIImageView = {
            let imageView = UIImageView(frame: cell.bounds)
            imageView.image = image
            imageView.layer.borderWidth = 1
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideSelectedCell)))
            imageView.isUserInteractionEnabled = true
            return imageView
        }()
        glassView.addSubview(imageView)
        
        let scaleWidth = min(glassView.bounds.width, glassView.bounds.height)/cell.bounds.width
        let scaleHeight = min(glassView.bounds.width, glassView.bounds.height)/cell.bounds.height
        
        let cellPosition: CGPoint = cell.convert(cell.bounds.origin, to: view)
        imageView.center = CGPoint(x: cellPosition.x + cell.bounds.width/2, y: cellPosition.y + cell.bounds.height/2)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut, animations: {
            imageView.transform = CGAffineTransform(scaleX: scaleWidth, y: scaleHeight)
            imageView.center = imageView.centerInContainingWindow()
            glassView.backgroundColor = .black.withAlphaComponent(0.5)
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                closeButton.alpha = 1.0
                imageView.layer.borderColor = UIColor.systemGray.cgColor
            }
        })
    }
    
    /// Анимация обратно к позиции selected-ячейки коллекции.
    @objc private func hideSelectedCell() {
        guard let cell = self.selectedCell,
              let glassView = view.subviews.first(where: { $0.bounds.size == UIScreen.main.bounds.size }),
              let closeButton = glassView.subviews.first(where: { $0 is UIButton }),
              let imageView = glassView.subviews.first(where: { $0 is UIImageView })
        else { return }
        
        let cellPosition: CGPoint = cell.convert(cell.bounds.origin, to: view)
        let cellCenter = CGPoint(x: cellPosition.x + cell.bounds.width/2, y: cellPosition.y + cell.bounds.height/2)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            imageView.transform = CGAffineTransformIdentity
            imageView.center = cellCenter
            glassView.backgroundColor = .clear
        }, completion: { _ in
            UIView.animate(withDuration: 0.3) {
                closeButton.alpha = 0
            }
            glassView.removeFromSuperview()
        })
    }
}

