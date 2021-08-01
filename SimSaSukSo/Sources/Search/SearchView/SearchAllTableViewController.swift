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
        
        
        self.searchAllTableView.reloadData() // a refresh the tableView.
        
    }
    
}
// MARK: - Table view data source
extension SearchAllTableViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(SearchAllTableViewController.lodgings.count)
        print(SearchAllTableViewController.alltags.count)
        print(SearchAllTableViewController.lodgings.count +  SearchAllTableViewController.alltags.count)
        return SearchAllTableViewController.lodgings.count +  SearchAllTableViewController.alltags.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        var cell = UITableViewCell()
                
        
        if SearchAllTableViewController.count < SearchAllTableViewController.lodgings.count{
            let lodging = SearchAllTableViewController.lodgings[SearchAllTableViewController.count]
            let allCell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
            allCell.firstLabel.text = lodging.name
            allCell.secondLabel.text = lodging.address
            cell = allCell
            
            print(indexPath.row)
            print("loding index : \(indexPath.row)")
            print("count :\(SearchAllTableViewController.count)")
            SearchAllTableViewController.count+=1
        }else if SearchAllTableViewController.count < SearchAllTableViewController.lodgings.count + SearchAllTableViewController.alltags.count  {
            let tags = SearchAllTableViewController.alltags[SearchAllTableViewController.count - SearchAllTableViewController.lodgings.count]
            let tagCell = tableView.dequeueReusableCell(withIdentifier: "SearchTagsTableViewCell", for: indexPath) as! SearchTagsTableViewCell
            tagCell.firstLabel.text = tags.keyword
            cell = tagCell
            print("tag index : \(indexPath.row)")
            SearchAllTableViewController.count+=1
            print("count :\(SearchAllTableViewController.count)")
        }
        
        
        
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
        
        let lodging = SearchAllTableViewController.lodgings[indexPath.row]
        cell.tag = lodging.generalLodgingIndex
        
        print(cell.tag)
        
        let searchResultVC = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
       
        searchResultVC.lodgingIndex = cell.tag
        searchResultVC.isTag = false
        
        self.present(searchResultVC, animated: true, completion: nil)
    }
    
    
}
