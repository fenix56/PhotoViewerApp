//
//  PhotoCollectionViewCell.swift
//  PhotoViewerApp
//
//  Created by Przemek on 29/10/2022.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "photoCell"
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
    }
}
