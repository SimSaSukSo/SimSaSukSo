//
//  SearchTagsViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/01.
//

import UIKit


class SearchTagsViewController: UIViewController {
    
    
    @IBOutlet var searchTagsTableView: UITableView!
    
    lazy var dataManager = SearchDataManager()
    
    static var keywords: [SearchTagResult] = []
    
    static var searchWord = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        searchTagsTableView.delegate = self
        searchTagsTableView.dataSource = self
        
    }
    
    @objc func refresh() {
        
        self.searchTagsTableView.reloadData() // a refresh the tableView.
        
    }
    
}
// MARK: - Table view data source
extension SearchTagsViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SearchTagsViewController.keywords.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTagsTableViewCell", for: indexPath) as! SearchTagsTableViewCell
        
        let keyword = SearchTagsViewController.keywords[indexPath.row]
        
        cell.firstLabel.text = keyword.keyword
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTagsTableViewCell", for: indexPath) as! SearchTagsTableViewCell
        
        let keyword = SearchTagsViewController.keywords[indexPath.row]
        cell.firstLabel.text = keyword.keyword
        
        let searchResultVC = self.storyboard?.instantiateViewController(identifier: "SearchResultViewController") as! SearchResultViewController
        
        searchResultVC.isTag = true
        searchResultVC.tag = cell.firstLabel.text!
        searchResultVC.searchResultName = cell.firstLabel.text!
        
        print(cell.firstLabel.text!)
        
        self.present(searchResultVC, animated: true, completion: nil)
    }
    
}

