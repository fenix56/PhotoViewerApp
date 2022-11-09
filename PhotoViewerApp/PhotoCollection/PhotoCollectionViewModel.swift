//
//  PhotoCollectionViewModel.swift
//  PhotoViewerApp
//
//  Created by Przemek on 31/10/2022.
//

import Foundation
import Photos
import UIKit

protocol AssetFetchable {
    func fetchImageAsset(_ index: Int, contentMode: PHImageContentMode, targetSize: CGSize?, options: PHImageRequestOptions?, completionHandler: ((UIImage) -> Void)?)
}

class PhotoCollectionViewModel: AssetFetchable {
    let photoManager: PhotoManagerActions
    
    init(photoManager: PhotoManagerActions) {
        self.photoManager = photoManager
    }
        
    func fetchPhotos() {
        photoManager.fetchPhotos()
    }

    func getPhoto(at index: Int) -> PHAsset {
        return photoManager.getPhoto(at: index)
    }
    
    var photosCount: Int {
        return photoManager.photosCount
    }
    
    func fetchImageAsset(_ index: Int, contentMode: PHImageContentMode, targetSize: CGSize?, options: PHImageRequestOptions?, completionHandler: ((UIImage) -> Void)?) {
        photoManager.fetchImageAsset(index, contentMode: contentMode, targetSize: targetSize, options: options) { image in
            completionHandler?(image)
        }
    }
}
