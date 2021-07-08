//
//  NewOneFeedViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/29.
//

import UIKit

class NewOneFeedViewController: UIViewController {
    
    lazy var dataManager = NewDataManager()
    
    static var newOneFeeds: [NewFeeds] = []

    @IBOutlet var newOneFeedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newOneFeedCollectionView.delegate = self
        newOneFeedCollectionView.dataSource = self
        
        dataManager.newOneFeed(delegate: self)
    }
    
}

//MARK: - CollectionView
extension NewOneFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return NewOneFeedViewController.newOneFeeds.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTabOneFeedCollectionViewCell", for: indexPath) as! NewTabOneFeedCollectionViewCell
        
        let newOneFeed = NewOneFeedViewController.newOneFeeds[indexPath.row]
        
        cell.imageViewHeight.constant = view.frame.size.height
        
        cell.nameLabel.text = newOneFeed.name
        
        cell.reliabilityLabel.text = newOneFeed.reliability
        let cellReliabilityLabel = Int(cell.reliabilityLabel.text!)
        if 41 > cellReliabilityLabel! {
            cell.faceImageView.image = UIImage(named: "angryFace")
            cell.reliabilityLabel.textColor = #colorLiteral(red: 0.9764705882, green: 0.07058823529, blue: 0.07058823529, alpha: 1)
        } else if 81 > cellReliabilityLabel! {
            cell.faceImageView.image = UIImage(named: "normalFace")
            cell.reliabilityLabel.textColor = #colorLiteral(red: 1, green: 0.6549019608, blue: 0.137254902, alpha: 1)
        } else {
            cell.faceImageView.image = UIImage(named: "goodFace")
            cell.reliabilityLabel.textColor = #colorLiteral(red: 0.1215686275, green: 0.8784313725, blue: 0.3803921569, alpha: 1)
        }
        
        cell.degreeLabel.text = "\(newOneFeed.degree)"
        
        // 이미지 URL 가져오기
        let urlString = newOneFeed.source
        if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.imageView.image = UIImage(data: data)
        }
        
        return cell
    }
}

//MARK: - CollectionView FlowLayout
extension NewOneFeedViewController: UICollectionViewDelegateFlowLayout {
    
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

extension NewOneFeedViewController {
    
    func newOneFeed(result: NewResult) {
        NewOneFeedViewController.newOneFeeds = result.feeds!
        newOneFeedCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
