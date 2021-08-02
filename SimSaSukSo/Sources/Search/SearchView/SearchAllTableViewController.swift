//
//  SearchAllTableViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

import UIKit


class SearchAllTableViewController: UIViewController {
    
    @IBOutlet var searchAllTableView: UITableView!
    
    lazy var dataManager = SearchDataManager()
    static var count : Int = 0
    static var lodgings: [Lodgings] = []
    static var alltags : [Tag] = []
    static var searchWord = "s"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        searchAllTableView.delegate = self
        searchAllTableView.dataSource = self
        
    }
    
    @objc func refresh() {
        
        SearchAllTableViewController.count = 0
        self.searchAllTableView.reloadData() // a refresh the tableView.
        
        
    }
    
}
// MARK: - Table view data source
extension SearchAllTableViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return SearchAllTableViewController.lodgings.count
        case 1:
            return SearchAllTableViewController.alltags.count
        default:
            return SearchAllTableViewController.lodgings.count +  SearchAllTableViewController.alltags.count
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let allCell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
            let lodging = SearchAllTableViewController.lodgings[indexPath.row]
            allCell.firstLabel.text = lodging.name
            allCell.secondLabel.text = lodging.address
            return allCell
        case 1:
            let tagCell = tableView.dequeueReusableCell(withIdentifier: "SearchTagsTableViewCell", for: indexPath) as! SearchTagsTableViewCell
            let tags = SearchAllTableViewController.alltags[indexPath.row]
            tagCell.firstLabel.text = tags.keyword
            return tagCell
        default:
            return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
            
            let lodging = SearchAllTableViewController.lodgings[indexPath.row]
            cell.tag = lodging.generalLodgingIndex
            cell.firstLabel.text = lodging.name
            print(cell.tag)
            
            let searchResultVC = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
            
            searchResultVC.lodgingIndex = cell.tag
            searchResultVC.isTag = false
            searchResultVC.searchResultName = cell.firstLabel.text!
            
            self.present(searchResultVC, animated: true, completion: nil)
        case 1:
            let tagCell = tableView.dequeueReusableCell(withIdentifier: "SearchTagsTableViewCell", for: indexPath) as! SearchTagsTableViewCell
            let tags = SearchAllTableViewController.alltags[indexPath.row]
            tagCell.firstLabel.text = tags.keyword
            
            let searchResultVC = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
            searchResultVC.isTag = true
            searchResultVC.tag = tagCell.firstLabel.text!
            searchResultVC.searchResultName = tagCell.firstLabel.text!
            self.present(searchResultVC, animated: true, completion: nil)
        default:
            print("")
        }
        
        
    }
    
    
}
