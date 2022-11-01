//
//  MockPhotoManager.swift
//  PhotoViewerAppTests
//
//  Created by Przemek on 01/11/2022.
//

import Foundation
import Photos
import UIKit
@testable import PhotoViewerApp

final class MockPhotoManager: PhotoManagerActions {
    private var assets: [PHAsset] = []
    
    var photosCount: Int {
        return assets.count
    }
    
    func fetchPhotos() {
        assets = [PHAsset(), PHAsset()]
    }
    
    func getPhoto(at index: Int) -> PHAsset {
        return assets[index]
    }
    
    func fetchImageAsset(_ index: Int, contentMode: PHImageContentMode, targetSize: CGSize?, options: PHImageRequestOptions?, completionHandler: ((UIImage) -> Void)?) {
        completionHandler?(UIImage())
    }
}
