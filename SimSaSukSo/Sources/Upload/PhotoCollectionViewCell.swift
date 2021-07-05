//
//  PhotoCollectionViewCell.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/05.
//

import UIKit
import Photos

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    
    fileprivate let imageManager = PHImageManager()
    
    var representedAssetIdentifier: String?
        
        var thumbnailSize: CGSize {
            let scale = UIScreen.main.scale
            //return CGSize(width: 91 * scale, height: 91 * scale)
            return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.photoImageView.contentMode = .scaleAspectFill
        }
        
        override func prepareForReuse() {
            super.prepareForReuse()
        }
        
        func configure(with image: UIImage?) {
            self.photoImageView.image = image
        }
    
}
