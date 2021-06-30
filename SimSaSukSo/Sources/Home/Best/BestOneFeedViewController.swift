//
//  BestOneFeedViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/25.
//
import Foundation
import UIKit

class BestOneFeedViewController: UIViewController {

    @IBOutlet var bestOneFeedCollectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        bestOneFeedCollectionView.delegate = self
        bestOneFeedCollectionView.dataSource = self
        
    }
    
}

//MARK: - CollectionView
extension BestOneFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestTabOneFeedCollectionViewCell", for: indexPath) as! BestTabOneFeedCollectionViewCell
        
        cell.imageViewHeight.constant = view.frame.size.width
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedDetailViewController")
        feedVC?.modalPresentationStyle = .fullScreen
        self.present(feedVC!, animated: true, completion: nil)
        
    }
}

//MARK: - CollectionView FlowLayout
extension BestOneFeedViewController: UICollectionViewDelegateFlowLayout {
    
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
