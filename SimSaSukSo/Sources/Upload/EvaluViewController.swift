//
//  EvaluViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/02.
//

import UIKit

class EvaluViewController: UIViewController {
    
    @IBOutlet var evaluCollectionView: UICollectionView!
    @IBOutlet var evaluCollectionViewHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        evaluCollectionView.delegate = self
        evaluCollectionView.dataSource = self
        
        evaluCollectionViewHeight.constant = 192 * 10
        
    }

}

//MARK: - CollectionView
extension EvaluViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EvaluCollectionViewCell", for: indexPath) as! EvaluCollectionViewCell
        
        cell.setupViews()
        
        return cell
    }
    
}

extension EvaluViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 391, height: 192)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
