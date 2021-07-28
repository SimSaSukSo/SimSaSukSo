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
    
    
    var fetchingMore = false
    var page : Int = 1
    var stop : Bool = false
        
    @IBOutlet var newFeedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newFeedsCollectionView.dataSource = self
        newFeedsCollectionView.delegate = self
        
        dataManager.newFeeds(page: page, delegate: self)
    }
    
    
}

//MARK: - CollectionView
extension NewFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("count :\(NewFeedsViewController.newFeeds.count)")
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
                fetchingMore = true
                self.page += 1
                print("page : \(page)")
        
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
                    
                    self.dataManager.newFeeds(page:self.page, delegate: self)

                })
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
    
    func addnewFeeds(result: NewResult){
        
        NewFeedsViewController.newFeeds.append(contentsOf: result.feeds!)
        self.fetchingMore = false
        self.newFeedsCollectionView.reloadData()
       
        
    }
    
    func failedToRequest(message: String) {
        
        self.presentAlert(title: message)
    }
}
