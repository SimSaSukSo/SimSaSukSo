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
    
    var input = SearchImageRequest(pros: [], cons: [], minPrice: 0, maxPrice: 0, locationIdx: 0, interval: "")
    
    var searchResultName = ""
        
    @IBOutlet var searchResultLabel: UILabel!
    @IBOutlet var resultNumberLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var resultCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultCollectionView.delegate = self
        resultCollectionView.dataSource = self
        
        self.resultCollectionView.collectionViewLayout = CustomCircularCollectionViewLayout()
        
        dataManager.searchImage(input, delegate: self)
        
        searchResultLabel.text = "'\(searchResultName)' 검색결과"
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
        return searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchResultCollectionViewCell", for: indexPath) as! SearchResultCollectionViewCell
        
        let searchResult = searchResults[indexPath.row]
        // 이미지 URL 가져오기
        let urlString = searchResult.source
        if let urlstring = urlString!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
           let url = URL(string: urlstring),
           let data = try? Data(contentsOf: url) {
            cell.searchImageView.image = UIImage(data: data)
        }
        
        cell.tag = searchResult.feedIndex!
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = resultCollectionView.cellForItem(at: indexPath) as! SearchResultCollectionViewCell
        
        print(cell.tag)
        
        let feedStoryboard = UIStoryboard.init(name: "HomeStoryboard", bundle: nil)
        let feedVC = feedStoryboard.instantiateViewController(withIdentifier: "FeedDetailViewController") as! FeedDetailViewController
        
        feedVC.feedIndex = cell.tag
        
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
        resultCollectionView.reloadData()
        
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
