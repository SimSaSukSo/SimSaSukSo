//
//  FavoritesViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class FavoritesViewController : UIViewController {
    
    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    @IBAction func editButtonAction(_ sender: UIButton) {
    }
    @IBAction func addButtonAction(_ sender: UIButton) {
    }
}

//MARK: - CollectionView
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        cell.stacView.layer.cornerRadius = 4
        
        return cell
    }
    
    
}

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widh = view.frame.size.width/2-(11+16)
        return CGSize(width: widh, height: widh + 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 24
    }
}
