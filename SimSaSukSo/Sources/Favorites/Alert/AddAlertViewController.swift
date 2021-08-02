//
//  AddAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/12.
//

import UIKit

class AddAlertViewController: UIViewController {
    
    lazy var dataManager = FavoriteDataManager()

    @IBOutlet var alertView: UIView!
    @IBOutlet var addTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func addButtonAction(_ sender: UIButton) {
        let title = addTextField.text!
        let input = FavoriteAddRequest(title: title)
        
        dataManager.favoriteAdd(input, delegate: self)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        dismiss(animated: false, completion: nil)
    }
    

}
//MARK: - API
extension AddAlertViewController {
    func favoriteAdd(_ result: FavoriteAddResponse) {
        print("성공")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
}
