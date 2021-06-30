//
//  BestFeedsViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/26.
//

import UIKit

class BestFeedsViewController: UIViewController {
    
    static let testFeedsArray = [1,2,3,4,5,6,7,8,9,10]

    @IBOutlet var bestFeedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bestFeedsCollectionView.dataSource = self
        bestFeedsCollectionView.delegate = self
    }
    

}

//MARK: - CollectionView
extension BestFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BestFeedsViewController.testFeedsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFeedCollectionViewCell", for: indexPath) as! MyFeedCollectionViewCell
        
        return cell
    }
    
    
}

//MARK: - CollectionView FlowLayout
extension BestFeedsViewController: UICollectionViewDelegateFlowLayout {
    
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
