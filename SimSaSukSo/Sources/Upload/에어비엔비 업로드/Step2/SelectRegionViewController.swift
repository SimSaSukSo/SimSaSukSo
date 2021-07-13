//
//  SelectRegionViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/14.
//

import UIKit
class SelectRegionViewController : UIViewController{
    
    @IBOutlet weak var regionTableView: UITableView!
    
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    var regionList : Array<String> = []
    var seoulList = ["TJDSD","DFSDF","DFSDF","SDSDFSD"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        regionTableView.dataSource = self
        regionTableView.delegate = self
        self.regionTableView.rowHeight = viewHeight.constant/17;
        regionList = seoulList
        
        //네비게이션 바 라인 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    @objc func cellClicked(_ sender: UIButton) {
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitleColor(.simsasuksoGreen, for: .selected)
            
            
        } else {
            sender.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
            
            
        }
        }
    
}

extension SelectRegionViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        regionList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell") as! RegionTableViewCell
        
        cell.regionButton.setTitle(regionList[indexPath.row], for: .normal)
        cell.regionButton.addTarget(self, action: #selector(self.cellClicked), for: .touchUpInside)
        return cell
    }
    
    
}
