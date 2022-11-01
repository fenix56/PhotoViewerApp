//
//  PhotoViewController.swift
//  PhotoViewerApp
//
//  Created by Przemek on 29/10/2022.
//

import UIKit
import Photos

enum ImageContentMode {
    case aspectFill
    case aspectFit
}

class PhotoViewController: UIViewController {
    @IBOutlet weak var photoView: UIImageView!
    var assetImage: UIImage? { didSet {
        getPhoto()
    }}
    
    private var aspectType = ImageContentMode.aspectFill
    private var maskLayer: CALayer?
    private var boundsDict: [ImageContentMode: CGRect] = [:]
    
    @IBAction func magnifyButtonTapped(_ sender: Any) {
        setImageAspect()
        guard let bounds = boundsDict[aspectType] else {
            identifyAndDrawLayer()
            return
        }
        maskLayer?.frame = bounds
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getPhoto()
        identifyAndDrawLayer()
    }
    
    func getPhoto() {
        if photoView != nil {
            photoView.image = assetImage
        }
    }
    
    private func identifyAndDrawLayer() {
       let bounds =  photoView.detectRectangle()
        boundsDict[aspectType] = bounds
        createLayer(in: bounds)
    }
    
    private func createLayer(in rect: CGRect) {
        if maskLayer == nil {
            maskLayer = CAShapeLayer()
        }
        if let maskLayer = maskLayer {
            maskLayer.frame = rect
            maskLayer.cornerRadius = 10
            maskLayer.opacity = 0.75
            maskLayer.borderColor = UIColor.red.cgColor
            maskLayer.borderWidth = 3.0

            photoView.layer.insertSublayer(maskLayer, at: 1)
        }
    }

    private func setImageAspect() {
        let contentMode: UIView.ContentMode
        switch aspectType {
        case .aspectFill:
             contentMode = .scaleToFill
            aspectType = .aspectFit
        case .aspectFit:
            contentMode = .scaleAspectFit
            aspectType = .aspectFill
        }
        UIView.transition(with: photoView, duration: 0.5,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.photoView.contentMode = contentMode
                          },
                          completion: nil)
    }
}
