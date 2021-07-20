//
//  FavoritesViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class FavoritesViewController : UIViewController {

    lazy var dataManager = FavoriteDataManager()
    
    var favoriteLists: [FavoriteResult] = []
    
    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        dataManager.favoriteList(delegate: self)
        
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
        
        return favoriteLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let favoriteList = favoriteLists[indexPath.row]
        let images = [cell.firstImageView, cell.secondImageView, cell.thirdImageView, cell.fourthImageView]
        
        cell.stackView.layer.cornerRadius = 10
        cell.titleLabel.text = favoriteList.title
        cell.tag = favoriteList.savedListIndex
        
        // 이미지 넣기
        for i in 0..<favoriteList.sources.count {
            let urlString = favoriteList.sources[i]
            if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                images[i]!.image = UIImage(data: data)
            }
        }
        
        return cell
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let cell = favoriteCollectionView.cellForItem(at: indexPath) as! FavoriteCollectionViewCell
//
//
//    }
    
    // 찜 Index 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! FavoriteDetailViewController
            detailVC.favoriteIndex = (sender as! UICollectionViewCell).tag
        }
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

//MARK: - API
extension FavoritesViewController {
    
    func favoriteLists(result: FavoriteResponse) {
        favoriteLists = result.result!
        favoriteCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
    
}
