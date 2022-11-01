//
//  PhotoManager.swift
//  PhotoViewerApp
//
//  Created by MAC on 01/11/22.
//

import Foundation
import Photos
import UIKit

protocol PhotoManagerActions {
    var photosCount: Int {get}
    func fetchPhotos()
    func getPhoto(at index: Int) -> PHAsset
    func fetchImageAsset(_ index: Int, contentMode: PHImageContentMode, targetSize: CGSize?, options: PHImageRequestOptions?, completionHandler: ((UIImage) -> Void)?)
}

final class PhotoManager {
    private let assetsLimit = 1000
    private let cachingTargetSize = CGSize(width: 100, height: 100)
    
    private var photos = PHFetchResult<PHAsset>()
    private let imageManager = PHCachingImageManager()
    
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
}

extension PhotoManager: PhotoManagerActions {
    var photosCount: Int {
        return photos.count
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
    func getPhoto(at index: Int) -> PHAsset {
        return photos[index]
    }
    
    func fetchImageAsset(_ index: Int, contentMode: PHImageContentMode, targetSize: CGSize? = nil, options: PHImageRequestOptions? = nil, completionHandler: ((UIImage) -> Void)?) {
        
        let asset = photos[index]
        
        let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { image, _ in
            completionHandler?(image ?? UIImage())
        }
        
        imageManager.requestImage(
            for: asset,
            targetSize: targetSize ?? cachingTargetSize,
            contentMode: contentMode,
            options: options,
            resultHandler: resultHandler)
    }
}
