//
//  AppCoordinator.swift
//  PhotoViewerApp
//
//  Created by Przemek on 31/10/2022.
//

import Foundation
import UIKit
import Photos

protocol Coordinator: AnyObject {
    func start()
    func showDetails(_ index: Int, viewModel: PhotoCollectionViewModel)
}

class AppCoordinator: Coordinator {
    private let navigationIdentifier = "navigationController"
    private let photoViewIndentifier = "photoViewController"
    
    private weak var window: UIWindow?
    private let storyboard: UIStoryboard
    private let navController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navController = storyboard.instantiateViewController(withIdentifier: navigationIdentifier) as? UINavigationController else {
            fatalError("ERROR!")
        }
        self.navController = navController
    }
    
    func start() {
        guard let photoCollectionVC = navController.viewControllers.first as? PhotoCollectionViewController else {
            fatalError("Couldn't instantiate PhotoCollectionViewController!")
        }
        photoCollectionVC.viewModel = PhotoCollectionViewModel( photoManager: PhotoManager())
        photoCollectionVC.coordinator = self
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func showDetails(_ index: Int, viewModel: PhotoCollectionViewModel) {
        guard let photoVC = storyboard.instantiateViewController(withIdentifier: photoViewIndentifier) as? PhotoViewController else {
            fatalError("Couldn't instantiate PhotoViewController!")
        }
        viewModel.fetchImageAsset(index, contentMode: .aspectFit, targetSize: UIScreen.main.bounds.size, options: nil, completionHandler: { image in
            photoVC.assetImage = image
        })
        navController.pushViewController(photoVC, animated: true)
    }
}
