//
//  EditAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/16.
//

import UIKit

//protocol editCellProtocol {
//    func presentDeleteVC()
//}

class EditAlertViewController: UIViewController {
    
    lazy var dataManager = FavoriteDataManager()
    
    var favoriteLists: [FavoriteResult] = []
    var favoriteIndex = 0
    
    var text: String = ""
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var editTableView: UITableView!
    @IBOutlet var editTableViewHeight: NSLayoutConstraint!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        alertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        editTableView.delegate = self
        editTableView.dataSource = self
        
        editTableViewHeight.constant = CGFloat(51 * 3)
        
        dataManager.favoriteList(delegate: self)
        
    }
    
    override func viewWillLayoutSubviews() {
        dataManager.favoriteList(delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataManager.favoriteList(delegate: self)
    }
    
    //    func presentDeleteVC() {
    //        let deleteVC = self.storyboard?.instantiateViewController(withIdentifier: "DeleteAlertViewController")
    //        self.present(deleteVC!, animated: false, completion: nil)
    //
    //    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let input = FavoriteEditRequest(savedListIndex: 35, title: "d")
        dataManager.favoriteEdit(input, delegate: self)
        dismiss(animated: false, completion: nil)
    }
    
    
}

extension EditAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteLists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteEditTableViewCell", for: indexPath) as! FavoriteEditTableViewCell
        
        let favoriteList = favoriteLists[indexPath.row]
        
        cell.editTextField.layer.cornerRadius = 4
        cell.editTextField.setLeftPaddingPoints(10)
        //cell.delegate = self
        
        cell.deleteButton.tag = favoriteList.savedListIndex
        cell.editTextField.text = favoriteList.title
        
        cell.deleteButton.setTitle(cell.editTextField.text, for: .normal)
        
        return cell
    }
    
    // 찜 타이틀 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDelete" {
            let deleteVC = segue.destination as! DeleteAlertViewController
            deleteVC.titleLabel = (sender as! UIButton).currentTitle!
            deleteVC.favoriteIndex = (sender as! UIButton).tag
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 51
    }
    
}

//MARK: - API
extension EditAlertViewController {
    func favoriteLists(result: FavoriteResponse) {
        favoriteLists = result.result!
        editTableView.reloadData()
    }
    
    func favoriteEdit(_ result: FavoriteEditResponse) {
        
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
