//
//  NewFeedsViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/29.
//

import UIKit

class NewFeedsViewController: UIViewController {
    
    lazy var dataManager = NewDataManager()
    
    static var newFeeds: [NewFeeds] = []

    @IBOutlet var newFeedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newFeedsCollectionView.dataSource = self
        newFeedsCollectionView.delegate = self
        
        dataManager.newFeeds(delegate: self)
    }
    

}

//MARK: - CollectionView
extension NewFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewFeedsViewController.newFeeds.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewFeedsCollectionViewCell", for: indexPath) as! NewFeedsCollectionViewCell
        
        let newFeed = NewFeedsViewController.newFeeds[indexPath.row]
        
        // 이미지 URL 가져오기
        let urlString = newFeed.source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.imageView.image = UIImage(data: data)
        }
        
        return cell
    }
    
    
}

//MARK: - CollectionView FlowLayout
extension NewFeedsViewController: UICollectionViewDelegateFlowLayout {
    
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
extension NewFeedsViewController {
    
    func newFeeds(result: NewResult) {
        NewFeedsViewController.newFeeds = result.feeds!
        newFeedsCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
