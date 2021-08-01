//
//  FavoritesViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class FavoritesViewController : UIViewController {

    lazy var dataManager = FavoriteDataManager()
    var favoriteResult : FavoriteResult = FavoriteResult(savedListIndex: 0, title: "", sources: [])
    var favoriteLists: [FavoriteResult] = []
    static var indexList : [Int] = []
    @IBOutlet var favoriteCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        
        dataManager.favoriteList(delegate: self)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataManager.favoriteList(delegate: self)
    }
    
    override func viewWillLayoutSubviews() {
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
        
        print(favoriteLists.count)
        return favoriteLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath) as! FavoriteCollectionViewCell
        
        let favoriteList = favoriteLists[indexPath.row]
        let images = [cell.firstImageView, cell.secondImageView, cell.thirdImageView, cell.fourthImageView]
        
        cell.stackView.layer.cornerRadius = 10
        cell.titleLabel.text = favoriteList.title
        cell.tag = favoriteList.savedListIndex
       
        FavoritesViewController.indexList.append(cell.tag)
        print(FavoritesViewController.indexList)
        
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
       // print("count : \(favoriteLists.count)")
//        if favoriteLists.count > 0{
//
//            for i in 0...favoriteLists.count - 1{
//
//                var favoriteList = favoriteLists[i]
//
//                FavoritesViewController.indexList.append(favoriteList.savedListIndex)
//                print(favoriteList.savedListIndex)
//                print("indexlist : \(FavoritesViewController.indexList)")
//            }
//        }
        
        
        favoriteCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
    
}
