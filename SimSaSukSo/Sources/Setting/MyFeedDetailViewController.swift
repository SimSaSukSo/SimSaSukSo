//
//  MyFeedDetailViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/21.
//

import UIKit

class MyFeedDetailViewController: UIViewController {

    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var userNicknameLabel: UILabel!
    @IBOutlet var feedImageView: UIImageView!
    
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var faceIconImageView: UIImageView!
    
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var tagCollectionView: UICollectionView!
    
    @IBOutlet var linkStackView: UIStackView!
    @IBOutlet var seeLinkButton: UIButton!
    
    @IBOutlet var commentUserImageView: UIImageView!
    @IBOutlet var commentWriteButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height/2
        
        commentUserImageView.layer.cornerRadius = commentUserImageView.frame.size.height/2
        commentWriteButton.layer.cornerRadius = 15
        
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        print("게시글 삭제")
    }
    @IBAction func heartButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func seeLinkButtonAction(_ sender: UIButton) {
        linkStackView.isHidden = true
    }
    
    @IBAction func commentWriteButtonAction(_ sender: UIButton) {
        print("게시")
    }
    
}

//MARK: - CollectionView

extension MyFeedDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCollectionViewCell", for: indexPath)
        
        return cell
    }
    
    
}

//MARK: - CollectionView FlowLayout

extension MyFeedDetailViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 40, height: 23)
    }
    
}
