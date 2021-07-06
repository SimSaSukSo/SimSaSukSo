//
//  UploadViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import Foundation
import UIKit
import Photos
import FirebaseStorage
import FirebaseAuth

class UploadViewController : UIViewController {
    
    let storage = Storage.storage()

    var allMedia: PHFetchResult<PHAsset>?
    let scale = UIScreen.main.scale
    var thumbnailSize = CGSize.zero
    
    var uploadPhotos = [UIImage]()
    var photoArray = [Int]()
    
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
        
        let image = UIImage(named: "evalu_Star_Fill")
        uploadImage(image: image!)
        
    }
    
   
  

    
    //MARK: - Function
    
    // Firebase 업로드
    func uploadImage(image: UIImage) {
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = "무야호"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storage.reference().child(filePath).putData(data, metadata: metaData) {
            (metaData, error) in if let error = error {
                print("실패")
                return
            } else {
                print("성공")
            }
        }

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
        
        if indexPath.row == 0 {
            photoImageView.image = cell.photoCellImageView.image
        }
        
        //cell.numberLabel.isHidden = true
        
        
        cell.numberLabel.layer.cornerRadius = cell.numberLabel.frame.size.height/2
        cell.numberLabel.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = photoCollectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        
        self.photoImageView.image = cell.photoCellImageView.image
        
    }
        

}


//MARK: - CollecitonView FlowLayout
extension UploadViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = CGSize(width: 91, height: 91)
        
        return size
    }

}

//MARK: - LocalImageManager
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

