//
//  NewOneFeedViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/29.
//

import UIKit

class NewOneFeedViewController: UIViewController {

    @IBOutlet var newOneFeedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newOneFeedCollectionView.delegate = self
        newOneFeedCollectionView.dataSource = self
        
    }
    
}

//MARK: - CollectionView
extension NewOneFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTabOneFeedCollectionViewCell", for: indexPath) as! NewTabOneFeedCollectionViewCell
        
        cell.imageViewHeight.constant = view.frame.size.height
        
        return cell
    }
}

//MARK: - CollectionView FlowLayout
extension NewOneFeedViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.size.width
        
        return CGSize(width: width, height: width + 54)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
}
