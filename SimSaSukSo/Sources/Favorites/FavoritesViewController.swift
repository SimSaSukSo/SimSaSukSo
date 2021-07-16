//
//  FavoritesViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class FavoritesViewController : UIViewController {
    
    var test = ["하이", "하이하이", "라라라라라라"]
    
    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
    }
    
    
    @IBAction func editButtonAction(_ sender: UIButton) {
        let editVC = self.storyboard?.instantiateViewController(identifier: "EditAlertViewController")
        
        self.present(editVC!, animated: false, completion: nil)
    }
    @IBAction func addButtonAction(_ sender: UIButton) {
        let addVC = self.storyboard?.instantiateViewController(identifier: "AddAlertViewController")
        
        self.present(addVC!, animated: false, completion: nil)
    }
}

//MARK: - CollectionView
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return test.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let list = test[indexPath.row]
        
        cell.stacView.layer.cornerRadius = 4
        cell.titleLabel.text = list
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(identifier: "FavoriteDetailViewController")
        
        self.navigationController?.pushViewController(detailVC!, animated: true)
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
