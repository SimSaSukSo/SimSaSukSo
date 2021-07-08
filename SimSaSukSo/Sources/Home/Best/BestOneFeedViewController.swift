//
//  BestOneFeedViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/25.
//
import Foundation
import UIKit

class BestOneFeedViewController: UIViewController {
    
    lazy var dataManager = BestDataManager()
    
    var bestOneFeeds: [BestFeeds] = []
    
    @IBOutlet var bestOneFeedCollectionView: UICollectionView!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        bestOneFeedCollectionView.delegate = self
        bestOneFeedCollectionView.dataSource = self
        
        dataManager.bestOneFeed(delegate: self)
    }
    
}

//MARK: - CollectionView
extension BestOneFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bestOneFeeds.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BestTabOneFeedCollectionViewCell", for: indexPath) as! BestTabOneFeedCollectionViewCell
        
        let bestOneFeed = bestOneFeeds[indexPath.row]
        
        cell.imageViewHeight.constant = view.frame.size.width
        
        cell.nameLabel.text = "\(bestOneFeed.name)"
        
        cell.reliabilityLabel.text = "\(bestOneFeed.reliability)"
        let cellReliabilityLabel = Int(cell.reliabilityLabel.text!)
        if 41 > cellReliabilityLabel! {
            cell.faceImageView.image = UIImage(named: "angryFace")
        } else if 81 > cellReliabilityLabel! {
            cell.faceImageView.image = UIImage(named: "normalFace")
        } else {
            cell.faceImageView.image = UIImage(named: "goodFace")
        }
        
        cell.degreeLabel.text = "\(bestOneFeed.degree)"
        
        // 이미지 URL 가져오기
        let urlString = bestOneFeed.source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.imageView.image = UIImage(data: data)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let feedVC = self.storyboard?.instantiateViewController(withIdentifier: "FeedDetailViewController")
        self.navigationController?.pushViewController(feedVC!, animated: true)
//        feedVC?.modalPresentationStyle = .fullScreen
//        self.present(feedVC!, animated: true, completion: nil)
        
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

//MARK: - API

extension BestOneFeedViewController {
    
    func bestOneFeed(result: BestResult) {
        bestOneFeeds = result.feeds!
        bestOneFeedCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
