//
//  BestFeedsViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/26.
//

import UIKit

class BestFeedsViewController: UIViewController {
    
    lazy var dataManager = BestDataManager()
    
    static var bestFeeds: [BestFeeds] = []
    
    @IBOutlet var bestFeedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bestFeedsCollectionView.dataSource = self
        bestFeedsCollectionView.delegate = self
        
        dataManager.bestFeeds(delegate: self)
    }
    

}

//MARK: - CollectionView
extension BestFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return BestFeedsViewController.bestFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestFeedsCollectionViewCell", for: indexPath) as! BestFeedsCollectionViewCell
        
        let bestFeed = BestFeedsViewController.bestFeeds[indexPath.row]
        
        // 이미지 URL 가져오기
        let urlString = bestFeed.source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.imageView.image = UIImage(data: data)
        }
        
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

//MARK: - API
extension BestFeedsViewController {
    
    func bestFeeds(result: BestResult) {
        BestFeedsViewController.bestFeeds = result.feeds!
        bestFeedsCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
