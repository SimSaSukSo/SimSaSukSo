//
//  NewFeedsViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/29.
//

import UIKit

class NewFeedsViewController: UIViewController {

    @IBOutlet var newFeedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newFeedsCollectionView.dataSource = self
        newFeedsCollectionView.delegate = self
    }
    

}

//MARK: - CollectionView
extension NewFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFeedCollectionViewCell", for: indexPath) as! MyFeedCollectionViewCell
        
        return cell
    }
    
    
}

//MARK: - CollectionView FlowLayout
extension NewFeedsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width/3-3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
}
