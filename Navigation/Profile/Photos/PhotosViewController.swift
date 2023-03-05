import UIKit

final class PhotosViewController: UIViewController {
    
    weak var parentNavigationController: UINavigationController? = nil
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        parentNavigationController?.navigationBar.isHidden = true
    }
    
    private func setup() {
        view.backgroundColor = .systemGray6
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Metric.inset),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Metric.inset),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Metric.inset),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Metric.inset),
        ])
    }
    
    func selectPhoto(imageIndex: Int) {
        if model.indices.contains(imageIndex) {
            print(#function, imageIndex)
            let indexPath = self.collectionView.indexPathsForSelectedItems?.last ?? IndexPath(item: imageIndex, section: 0)
            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredVertically)
        }
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
        ///print(#function, indexPath, collectionView.cellForItem(at: indexPath)?.isSelected)
    }
    
}

extension PhotosViewController {
    
    private enum Metric {
        static let cellsInRow: CGFloat = 3
        static let cellSpacing: CGFloat = 8
        static let inset: CGFloat = 8
    }
    
}
