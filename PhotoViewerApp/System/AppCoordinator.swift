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
        photoCollectionVC.viewModel = PhotoCollectionViewModel(imageManager: PHCachingImageManager())
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
