//
//  SearchAllTableViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

import UIKit

protocol searchDelegate {
    func searchWord(data: String)
}
class SearchAllTableViewController: UITableViewController {

    lazy var dataManager = SearchDataManager()
    
    var lodgings: [Lodgings] = []
    
    var searchWord = "s"
    
    let searchViewC = SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //dataManager.searchAll(delegate: self, url: "https://dev.enudgu.shop/api/feeds/search/total?searchWord=\(searchWord)")
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return lodgings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
        
        let lodging = lodgings[indexPath.row]
        
        cell.firstLabel.text = lodging.name
        cell.secondLabel.text = lodging.address

        return cell
    }
    
}

//MARK: - API
extension SearchAllTableViewController {
    func searchAll(result: SearchAllResponse) {
        lodgings = result.result!.lodging!
        tableView.reloadData()
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}

extension SearchAllTableViewController: searchDelegate {
    func searchWord(data: String) {
        searchWord = data
    }
    
}

//MARK: - SearchBar
extension SearchAllTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchVC = self.storyboard?.instantiateViewController(identifier: "SearchViewController") as! SearchViewController
        searchWord = searchVC.searchBar.text!
        dataManager.searchAll(delegate: self, url: "https://dev.enudgu.shop/api/feeds/search/total?searchWord=\(searchWord)")
        print(searchWord)
    }
}
