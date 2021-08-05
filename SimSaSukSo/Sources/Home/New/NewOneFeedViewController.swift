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
    
    var fetchingMore = false
    var page : Int = 1
    var stop : Bool = false
    
    @IBOutlet var newOneFeedCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newOneFeedCollectionView.delegate = self
        newOneFeedCollectionView.dataSource = self
        
        dataManager.newOneFeed(page: page, delegate: self)
        print("new one feed")
    }
    
}

//MARK: - CollectionView
extension NewOneFeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count :\(NewOneFeedViewController.newOneFeeds.count)")
        return NewOneFeedViewController.newOneFeeds.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewTabOneFeedCollectionViewCell", for: indexPath) as! NewTabOneFeedCollectionViewCell
        
        let newOneFeed = NewOneFeedViewController.newOneFeeds[indexPath.row]
        
        cell.imageViewHeight.constant = view.frame.size.height
        
        cell.nameLabel.text = newOneFeed.name
        
        cell.reliabilityLabel.text = "\(newOneFeed.reliability)"
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
        
        cell.tag = newOneFeed.feedIndex
        
        return cell
    }
    
    // Feed Index 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            let detailVC = segue.destination as! FeedDetailViewController
            detailVC.feedIndex = (sender as! UICollectionViewCell).tag
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
          let offsetY = scrollView.contentOffset.y
          let contentHeight = scrollView.contentSize.height
        
          if offsetY >= contentHeight - scrollView.frame.size.height {
            print("늘렸다")
            if !fetchingMore
                        {
                            beginBatchFetch()
                        }
             
          }
       }
    
    func beginBatchFetch()
        {
        if stop == false{
                fetchingMore = true
                self.page += 1
                print("page : \(page)")
        
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                    
                    self.dataManager.newOneFeed(page:self.page, delegate: self)

                })
        }else{
            print("마지막 페이지 입니다 / page : \(page)")
            
        }
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
    
    func addnewOneFeed(result: NewResult){
        
        NewOneFeedViewController.newOneFeeds.append(contentsOf: result.feeds!)
        self.fetchingMore = false
        stop = result.isLast
        self.newOneFeedCollectionView.reloadData()
       
        
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
