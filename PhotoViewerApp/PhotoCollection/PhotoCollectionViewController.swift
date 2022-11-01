//
//  PhotoCollectionViewController.swift
//  PhotoViewerApp
//
//  Created by Przemek on 29/10/2022.
//

import UIKit
import Photos

class PhotoCollectionViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var viewModel: PhotoCollectionViewModel?
    var coordinator: Coordinator?
    
    private var transitionInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getPermissionIfNeeded { permited in
            guard permited else { return }
            self.viewModel?.fetchPhotos()
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    private func getPermissionIfNeeded(completionHandler: @escaping (Bool) -> Void) {
        guard PHPhotoLibrary.authorizationStatus() != .authorized else {
            completionHandler(true)
            return
        }
        PHPhotoLibrary.requestAuthorization { status in
            completionHandler(status == .authorized ? true : false)
        }
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

// MARK: - CollectionView Data Source Extension
extension PhotoCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.photosCount ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let viewModel = viewModel, let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PhotoCollectionViewCell.reuseIdentifier,
            for: indexPath) as? PhotoCollectionViewCell else {
            fatalError("Unable to dequeue PhotoCollectionViewCell")
        }
        
        viewModel.fetchImageAsset(indexPath.item, contentMode: .aspectFit, targetSize: nil, options: nil) { image in
            cell.photoImageView.image = image
        }

        return cell
    }
}

extension PhotoCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let viewModel = viewModel {
            coordinator?.showDetails(indexPath.item, viewModel: viewModel)
        }
    }
}

// MARK: - CollectionView Delegate Flow Layout Extension
extension PhotoCollectionViewController: UICollectionViewDelegateFlowLayout {
    var itemsPerRow: CGFloat {
        return 4
    }
    
    var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
    }
    
    var widthPerItem: Double {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        return availableWidth / itemsPerRow
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}
