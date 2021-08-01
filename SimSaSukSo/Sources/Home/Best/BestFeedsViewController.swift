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
    
    static var nowTab : Int = 0 //전체1,숙소2,태그3,위치4
    var fetchingMore = false
    var page : Int = 1
    var stop : Bool = false
    
    
    @IBOutlet var bestFeedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bestFeedsCollectionView.dataSource = self
        bestFeedsCollectionView.delegate = self
        
        dataManager.bestFeeds(page: self.page, delegate: self)
    }
    

}

//MARK: - CollectionView
extension BestFeedsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(BestFeedsViewController.bestFeeds.count)
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
        
        cell.tag = bestFeed.feedIndex
        
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
                    
                    self.dataManager.bestFeeds(page: self.page, delegate: self)

                })
                }else{
                    print("마지막 페이지 입니다 / page : \(page)")
                }
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
    
    func addBestFeeds(result : BestResult){
        BestFeedsViewController.bestFeeds.append(contentsOf: result.feeds!)
        self.fetchingMore = false
        stop = result.isLast
        self.bestFeedsCollectionView.reloadData()
       
    }
        
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
