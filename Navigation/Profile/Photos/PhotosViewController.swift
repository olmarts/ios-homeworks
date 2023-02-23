//
//  PhotosViewController.swift
//  Navigation
//
//  Created by user1 on 22.02.2023.
//

import UIKit

final class PhotosViewController: UIViewController {
    
    var parentNavigationController: UINavigationController? = nil
    
    private let model: [UIImage] = Photos.makeMockModel(maxCount: 24)
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let rowWidth = min(view.bounds.width, view.bounds.height) - 16 // inset: 8*2
        let cellSpacing: CGFloat = 8
        let cellWidth = layout.calcCellWidth(rowWidth: rowWidth, cellSpacing: cellSpacing, cellsInRow: 3)
        layout.minimumInteritemSpacing = cellSpacing
        //layout.sectionInset = UIEdgeInsets(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth*1.0)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.register(PhotosCollectionViewCell.self,  forCellWithReuseIdentifier: PhotosCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let nav = parentNavigationController { nav.navigationBar.isHidden = true }
    }
    
    private func setup() {
        view.addSubview(collectionView)
        let inset: CGFloat = 8
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: inset),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: inset),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -inset),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -inset),
        ])
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
