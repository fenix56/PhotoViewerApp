//
//  UIImageView+Extension.swift
//  PhotoViewerApp
//
//  Created by Przemek on 29/10/2022.
//

import UIKit
import Photos
import Vision

extension UIImageView {
    // MARK: - Photos Image Request method
    func fetchImageAsset(_ asset: PHAsset?, imageManager: PHCachingImageManager, targetSize: CGSize, contentMode: PHImageContentMode = .aspectFill, options: PHImageRequestOptions? = nil, completionHandler: ((Bool) -> Void)?) {
        guard let asset = asset else {
            completionHandler?(false)
            return
        }
        
        let resultHandler: (UIImage?, [AnyHashable: Any]?) -> Void = { image, _ in
            self.image = image
            completionHandler?(true)
        }
        
        imageManager.requestImage(
            for: asset,
            targetSize: targetSize,
            contentMode: contentMode,
            options: options,
            resultHandler: resultHandler)
    }
    
    // MARK: - Attention-based saliency for image methods
    func detectRectangle() -> CGRect {
        
        guard let cgImage = self.image?.cgImage else {
            return CGRect.zero
        }
        let handler = VNImageRequestHandler(cgImage: cgImage)
        
        let request = VNGenerateAttentionBasedSaliencyImageRequest()
        
        request.revision = VNGenerateAttentionBasedSaliencyImageRequestRevision1
        
        try? handler.perform([request])
        
        guard let result = request.results?.first, let vnRectangle = result.salientObjects?.first else {
            return CGRect.zero
        }
        
       return drawBoundingBox(rect: vnRectangle)
    }
    
    func drawBoundingBox(rect: VNRectangleObservation) -> CGRect {
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -self.frame.size.height)

        let scale = CGAffineTransform.identity.scaledBy(x: self.frame.size.width, y: self.frame.size.height)

        return rect.boundingBox.applying(scale).applying(transform)

    }
    
    func removeMask() {
        if let sublayer = self.layer.sublayers?.first(where: { $0 as? CAShapeLayer != nil }) {
            sublayer.removeFromSuperlayer()
        }
    }
}
