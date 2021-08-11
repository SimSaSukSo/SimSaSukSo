//
//  UploadViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import Foundation
import UIKit
import Photos
import PhotosUI
import FirebaseStorage
import FirebaseAuth

class UploadViewController : UIViewController,PHPhotoLibraryChangeObserver {
   
    let storage = Storage.storage()
    
    var fetchResult = PHFetchResult<PHAsset>()
    var canAccessImages: [UIImage] = []
    var thumbnailSize: CGSize {
        let scale = UIScreen.main.scale
        return CGSize(width: (UIScreen.main.bounds.width / 3) * scale, height: 100 * scale)
    }
    
    static var uploadPhotos = [UIImage]()
    static var photoArray = [Int]()
    static var urlArray = [String]()
    
    var images = UploadViewController.uploadPhotos
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoImageViewHeight: NSLayoutConstraint!
    @IBOutlet var photosButton: UIButton!
    @IBOutlet var photoCollectionView: UICollectionView!
    @IBOutlet var photoCollectionViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        // 여기서 호출하게 되면 앱 삭제 후 처음 실행시 Add버튼을 누르지 않아도 사진 접근 권한 alert이 뜨게 된다.
        PHPhotoLibrary.shared().register(self)
        
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        photoCollectionView.reloadData()
        
        photoImageViewHeight.constant = photoImageView.frame.size.width
     
        
    }
    
    
  
    //MARK: - Function
    
    // Firebase 업로드
    func uploadImage(image: UIImage) {
        var data = Data()
        data = image.jpegData(compressionQuality: 0.8)!
        let filePath = "Upload"
        let imageName = "\(Int(NSDate.timeIntervalSinceReferenceDate * 1080)).jpg"
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        let ref = storage.reference().child(filePath).child(imageName)
       
        ref.putData(data, metadata: metaData) { metaData, error in
            if (error != nil) {
                print("실패")
            } else {
                ref.downloadURL { (downUrl, error) in
                    UploadViewController.urlArray.append(downUrl!.absoluteString)
                    print(UploadViewController.urlArray)
                    
                }
            }
        }

    }
    
 
    @IBAction func nextButtonAction(_ sender: UIButton) {
        let alertlVC = self.storyboard?.instantiateViewController(identifier: "UploadAlertViewController")
        
        self.present(alertlVC!, animated: false, completion: nil)
        
        
    }
    
    @IBAction func photosButtonAction(_ sender: UIButton) {
        self.requestPHPhotoLibraryAuthorization {
            self.getCanAccessImages()
        }
    }
    
    func requestPHPhotoLibraryAuthorization(completion: @escaping () -> Void) {
        if #available(iOS 14, *) {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { (status) in
                switch status {
                case .limited:
                    PHPhotoLibrary.shared().register(self)
                    completion()
                default:
                    break
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    
    func getCanAccessImages() {
        self.canAccessImages = []
        let requestOptions = PHImageRequestOptions()
        requestOptions.isSynchronous = true

        let fetchOptions = PHFetchOptions()
        self.fetchResult = PHAsset.fetchAssets(with: fetchOptions)
        self.fetchResult.enumerateObjects { (asset, _, _) in
            PHImageManager().requestImage(for: asset, targetSize: self.thumbnailSize, contentMode: .aspectFill, options: requestOptions) { (image, info) in
                guard let image = image else { return }
                self.canAccessImages.append(image)
                DispatchQueue.main.async {
                    self.photoCollectionView.insertItems(at: [IndexPath(item: self.canAccessImages.count - 1, section: 0)])
                }
            }
        }
    }
    
    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        self.getCanAccessImages()
    }
   
}

//MARK: - CollectionView
extension UploadViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.canAccessImages.count
      
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as! PhotoCollectionViewCell
        
       
        
        if indexPath.row == 0 {
            photoImageView.image = cell.photoCellImageView.image
        }
        
        cell.photoCellImageView.image = self.canAccessImages[indexPath.item]
        
        cell.blackView.isHidden = true
        cell.numberLabel.isHidden = true
        
        cell.numberLabel.layer.cornerRadius = cell.numberLabel.frame.size.height/2
        cell.numberLabel.layer.masksToBounds = true
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = photoCollectionView.cellForItem(at: indexPath) as! PhotoCollectionViewCell
        
        self.photoImageView.image = cell.photoCellImageView.image
        
        if cell.blackView.isHidden == true { // 선택안함 -> 선택
            cell.blackView.isHidden = false
            cell.numberLabel.isHidden = false
            UploadViewController.photoArray.append(indexPath.item)
            UploadViewController.uploadPhotos.append(cell.photoCellImageView.image!)
            uploadImage(image: cell.photoCellImageView.image!)
            print(UploadViewController.photoArray)
        } else { // 선택 취소
            cell.blackView.isHidden = true
            cell.numberLabel.isHidden = true
            UploadViewController.photoArray.removeAll{ ($0 == indexPath.item) }
            UploadViewController.uploadPhotos.removeAll{ ($0 == cell.photoCellImageView.image) }
            print(UploadViewController.photoArray)
        }
        
        if !UploadViewController.photoArray.isEmpty { // 배열 안비어있으면
            for i in 0...UploadViewController.photoArray.count-1 {
                if indexPath.item == UploadViewController.photoArray[i] {
                    cell.numberLabel.text = "✓"
                }
            }
        }
        
    }


}


//MARK: - CollecitonView FlowLayout
extension UploadViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width/4-4
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }

}


