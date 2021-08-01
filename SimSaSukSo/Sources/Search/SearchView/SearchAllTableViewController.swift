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
    
    static var lodgings: [Lodgings] = []
    
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
        
        return SearchAllTableViewController.lodgings.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
        
        let lodging = SearchAllTableViewController.lodgings[indexPath.row]
        
        cell.firstLabel.text = lodging.name
        cell.secondLabel.text = lodging.address
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
        
        let lodging = SearchAllTableViewController.lodgings[indexPath.row]
        cell.tag = lodging.generalLodgingIndex
        
        print(cell.tag)
        
        let searchResultVC = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
       
        searchResultVC.lodgingIndex = cell.tag
        
        self.present(searchResultVC, animated: true, completion: nil)
    }
    
    
}
