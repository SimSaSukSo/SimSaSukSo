//
//  UploadViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import Foundation
import UIKit
class UploadViewController : UIViewController {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var photoImageViewHeight: NSLayoutConstraint!
    @IBOutlet var photosButton: UIButton!
    @IBOutlet var photoCollectionView: UICollectionView!
    @IBOutlet var photoCollectionViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()
        
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        
        photoImageViewHeight.constant = photoImageView.frame.size.width
        photoCollectionViewHeight.constant = 91 * (20/4)
    }
    
    @IBAction func nextButtonAction(_ sender: UIButton) {
    }
    @IBAction func photosButtonAction(_ sender: UIButton) {
    }
}

//MARK: - CollectionView
extension UploadViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath)
        
        return cell
    }

}

//MARK: - CollecitonView FlowLayout
extension UploadViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 91, height: 91)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
}
