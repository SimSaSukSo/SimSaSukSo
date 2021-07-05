//
//  UploadViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import Foundation
import UIKit
import Photos

class UploadViewController : UIViewController {
    
    var allMedia: PHFetchResult<PHAsset>?
    let scale = UIScreen.main.scale
    var thumbnailSize = CGSize.zero
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoImageViewHeight: NSLayoutConstraint!
    @IBOutlet var photosButton: UIButton!
    @IBOutlet var photoCollectionView: UICollectionView!
    @IBOutlet var photoCollectionViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        // MAKR: - 모든 미디어 가져오는 메소드
        //self.allMedia = PHAsset.fetchAssets(with: nil)
        
        // MAKR: - 특정 타입(PHAssetMediaType) 미디어만 가져오는 메소드
        self.allMedia = PHAsset.fetchAssets(with: .image, options: nil)
        
        self.photoCollectionView.reloadData()
        self.thumbnailSize = CGSize(width: 1024 * self.scale, height: 1024 * self.scale)
        
        photoImageViewHeight.constant = photoImageView.frame.size.width
        photoCollectionViewHeight.constant = CGFloat(91 * (allMedia!.count/4) + 100)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
    }
    @IBAction func photosButtonAction(_ sender: UIButton) {
    }
}

//MARK: - CollectionView
extension UploadViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.allMedia?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
        let asset = self.allMedia?[indexPath.item]
        LocalImageManager.shared.requestIamge(with: asset, thumbnailSize: self.thumbnailSize) { (image) in
            cell.configure(with: image)
        }

        return cell
    }

}

//MARK: - CollecitonView FlowLayout
extension UploadViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 91, height: 91)
        
        return size
    }

}

final class LocalImageManager {
    
    static var shared = LocalImageManager()
    
    fileprivate let imageManager = PHImageManager()
    
    var representedAssetIdentifier: String?
    
    func requestIamge(with asset: PHAsset?, thumbnailSize: CGSize, completion: @escaping (UIImage?) -> Void) {
        guard let asset = asset else {
            completion(nil)
            return
        }
        self.representedAssetIdentifier = asset.localIdentifier
        self.imageManager.requestImage(for: asset, targetSize: thumbnailSize, contentMode: .aspectFill, options: nil, resultHandler: { image, info in
            // UIKit may have recycled this cell by the handler's activation time.
            //  print(info?["PHImageResultIsDegradedKey"])
            // Set the cell's thumbnail image only if it's still showing the same asset.
            if self.representedAssetIdentifier == asset.localIdentifier {
                completion(image)
            }
        })
    }
}
