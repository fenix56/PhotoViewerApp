//
//  PhotoCollectionViewModel.swift
//  PhotoViewerApp
//
//  Created by Przemek on 31/10/2022.
//

import Foundation
import Photos

class PhotoCollectionViewModel {
    let assetsLimit = 1000
    let cachingTargetSize = CGSize(width: 100, height: 100)
    
    private var photos = PHFetchResult<PHAsset>()
    let imageManager: PHCachingImageManager
    
    init(imageManager: PHCachingImageManager, photos: PHFetchResult<PHAsset> = PHFetchResult<PHAsset>()) {
        self.photos = photos
        self.imageManager = imageManager
    }
        
    func fetchPhotos() {
        let fetchOptions = PHFetchOptions()
        fetchOptions.fetchLimit = assetsLimit
        fetchOptions.sortDescriptors = [
            NSSortDescriptor(
                key: "creationDate",
                ascending: false)
        ]
        photos = PHAsset.fetchAssets(with: fetchOptions)
        cachePhotos()
    }
    
    private func cachePhotos() {
        let indexSet = IndexSet(0..<photos.count)
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true
        requestOptions.deliveryMode = .highQualityFormat
        imageManager.startCachingImages(
            for: photos.objects(at: indexSet),
            targetSize: cachingTargetSize,
            contentMode: .default,
            options: requestOptions)
    }
    
    func getPhoto(at index: Int) -> PHAsset {
        return photos[index]
    }
    
    var photosCount: Int {
        return photos.count
    }
}
