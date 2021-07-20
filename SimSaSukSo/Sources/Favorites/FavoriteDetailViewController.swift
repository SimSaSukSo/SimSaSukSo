//
//  FavoriteDetailViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/12.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
    
    lazy var dataManager = FavoriteDataManager()
    
    var favoriteDetailResult: FavoriteDetailResult?
    var favoriteDetailFeeds: [FavoriteDetailFeeds] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailCollectionView.delegate = self
        detailCollectionView.dataSource = self
        
        dataManager.favoriteDetail(delegate: self, url: "\(Constant.BASE_URL)api/lists/3")
    
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    @IBAction func filterButtonAction(_ sender: UIButton) {
    }
    
}

//MARK: - CollectionView
extension FavoriteDetailViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteDetailFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteDetailCollectionViewCell", for: indexPath) as! FavoriteDetailCollectionViewCell
        
        let favoriteDetailFeed = favoriteDetailFeeds[indexPath.row]
        
        // 이미지 URL 가져오기
        let urlString = favoriteDetailFeed.source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.imageView.image = UIImage(data: data)
        }
        
        return cell
    }
    
    
}

extension FavoriteDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.size.width/3-3
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
}

//MARK: - API
extension FavoriteDetailViewController {
    func favoriteDetail(result: FavoriteDetailResult) {
        titleLabel.text = result.title
        favoriteDetailFeeds = result.feeds!
        detailCollectionView.reloadData()
    }
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
