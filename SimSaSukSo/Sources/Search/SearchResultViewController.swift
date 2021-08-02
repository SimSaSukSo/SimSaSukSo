//
//  SearchResultViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/11.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    lazy var dataManager = SearchDataManager()
    
    var searchResults: [SearchImageResult] = []
    var searchIndexResults: [SearchLodgingIndexResult] = []
    var searchTagResults: [SearchTagImageResult] = []
    
    var input = SearchImageRequest(pros: [], cons: [], minPrice: 0, maxPrice: 0, locationIdx: 0, interval: "")
    
    var searchResultName = ""
    
    var lodgingIndex = 0
    var tag = ""
    var isTag: Bool?
    
    @IBOutlet var searchResultLabel: UILabel!
    @IBOutlet var resultNumberLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        self.resultCollectionView.collectionViewLayout = CustomCircularCollectionViewLayout()
        
        if input.locationIdx == 0 {
            searchResultLabel.text = "'\(searchResultName)' 검색결과"
            if isTag == false { // 전체, 숙소
                dataManager.searchLodgingIndex(delegate: self, url: "\(Constant.BASE_URL)api/feeds/search/lodging/\(lodgingIndex)")
            } else {
                dataManager.searchTagImage(delegate: self, url: "\(Constant.BASE_URL)api/feeds/search/tag?tag=\(tag)")
            }
            
        } else {
            dataManager.searchImage(input, delegate: self)
            searchResultLabel.text = "필터된 검색결과"
        }
        
        
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func searchButtonAction(_ sender: UIButton) {
        searchButton.isSelected = !searchButton.isSelected
        
        if searchButton.isSelected {
            searchButton.setImage(UIImage(named: "search_Best"), for: .normal)
        } else {
            searchButton.setImage(UIImage(named: "search_New"), for: .normal)
        }
    }
    

}

//MARK: - CollectionView
extension SearchResultViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if input.locationIdx == 0 {
            if isTag == false { // 전체, 숙소
                return searchIndexResults.count
            } else {
                return searchTagResults.count
            }
        } else { // 필터
            return searchResults.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCollectionViewCell", for: indexPath) as! SearchResultCollectionViewCell
        
        if input.locationIdx == 0 { // 전체, 숙소
            if isTag == false {
                let searchResult = searchIndexResults[indexPath.row]
                // 이미지 URL 가져오기
                let urlString = searchResult.source
                if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let url = URL(string: urlstring),
                   let data = try? Data(contentsOf: url) {
                    cell.searchImageView.image = UIImage(data: data)
                    
                    cell.tag = searchResult.feedIndex
                    }
                } else {
                    let searchResult = searchTagResults[indexPath.row]
                    // 이미지 URL 가져오기
                    let urlString = searchResult.source
                    if let urlstring = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: urlstring),
                       let data = try? Data(contentsOf: url) {
                        cell.searchImageView.image = UIImage(data: data)
                        
                        cell.tag = searchResult.feedIndex
                }
            
            }
        } else { // 필터
            let searchResult = searchResults[indexPath.row]
            // 이미지 URL 가져오기
            let urlString = searchResult.source
            if let urlstring = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
               let url = URL(string: urlstring),
               let data = try? Data(contentsOf: url) {
                cell.searchImageView.image = UIImage(data: data)
                
                cell.tag = searchResult.feedIndex!
            }
        
            }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = resultCollectionView.cellForItem(at: indexPath) as! SearchResultCollectionViewCell
        
        print(cell.tag)
        
        let feedStoryboard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let feedVC = feedStoryboard.instantiateViewController(withIdentifier: "FeedDetailViewController") as! FeedDetailViewController
        
        feedVC.feedIndex = cell.tag
        print(tag)
        self.present(feedVC, animated: true, completion: nil)
        
    }
    
    
}

extension SearchResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 3 {
            return CGSize(width: 249, height: 249)
        }
        return CGSize(width: 123, height: 123)
    }
}

//MARK: - API
extension SearchResultViewController {
    func searchImage(_ result: SearchImageResponse) {
        searchResults = result.result!
        resultNumberLabel.text = String(result.result!.count) + "개"
        if searchResults == nil {
            print("")
        } else {
            resultCollectionView.reloadData()
        }
        
        
    }
    
    func searchLodgingIndex(result: SearchLodgingIndexResponse) {
        searchIndexResults = result.result!
        resultNumberLabel.text = String(result.result!.count) + "개"
        resultCollectionView.reloadData()
    }
    
    func searchTagImage(result: SearchTagImageResponse) {
        searchTagResults = result.result!
        resultNumberLabel.text = String(result.result!.count) + "개"
        resultCollectionView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
