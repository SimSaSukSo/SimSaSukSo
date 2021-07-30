//
//  SearchAllTableViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

import UIKit

class SearchAllTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell", for: indexPath) as! AllTableViewCell
        
        return cell
    }
    
}
