//
//  EditAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/16.
//

import UIKit

protocol editCellProtocol {
    func presentDeleteVC()
}

class EditAlertViewController: UIViewController, editCellProtocol {
    
    lazy var dataManager = FavoriteDataManager()
    
    var text = ""
    
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
        
        editTableViewHeight.constant = 51 * 3
        
    }
    
    func presentDeleteVC() {
        let deleteVC = self.storyboard?.instantiateViewController(withIdentifier: "DeleteAlertViewController")
        self.present(deleteVC!, animated: false, completion: nil)
        
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func saveButtonAction(_ sender: UIButton) {
        let input = EditRequest(savedListIndex: 3, title: text)
        //dataManager.favoriteEdit(input, delegate: self)
        print(text)
        dismiss(animated: false, completion: nil)
    }
    

}

extension EditAlertViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteEditTableViewCell", for: indexPath) as! FavoriteEditTableViewCell
        
        cell.editTextField.layer.cornerRadius = 4
        cell.editTextField.setLeftPaddingPoints(10)
        cell.delegate = self
        
        cell.editTextField.text = "ff"
        text = cell.editTextField.text!
        
        return cell
    }
    
}

//MARK: - API
extension EditAlertViewController {
    func favoriteEdit(result: FavoriteEditResponse) {
        print("성공")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
