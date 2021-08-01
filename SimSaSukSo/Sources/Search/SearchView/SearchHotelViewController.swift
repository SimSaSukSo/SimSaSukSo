//
//  SearchHotelTableViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/01.
//

import UIKit


class SearchHotelViewController: UIViewController {

       @IBOutlet var searchHotelTableView: UITableView!
    
    lazy var dataManager = SearchDataManager()
    
    static var lodgings: [SearchLodgingsResult] = []
    
    static var searchWord = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        
        searchHotelTableView.delegate = self
        searchHotelTableView.dataSource = self
        
       print("숙소")
        
    }
    
    @objc func refresh() {

       self.searchHotelTableView.reloadData() // a refresh the tableView.

   }

}
    // MARK: - Table view data source
extension SearchHotelViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return SearchHotelViewController.lodgings.count
    }
 func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHotelTableViewCell", for: indexPath) as! AllTableViewCell
        
      let lodging = SearchHotelViewController.lodgings[indexPath.row]
        
        cell.firstLabel.text = lodging.name
        cell.secondLabel.text = lodging.address

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("무야호")
    }
    
}

