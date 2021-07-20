//
//  DeleteAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/16.
//

import UIKit

class DeleteAlertViewController: UIViewController {
    
    lazy var dataManager = FavoriteDataManager()
    
    var titleLabel: String = ""
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        contentsLabel.text = "'\(titleLabel)' 목록을 삭제하시겠습니까?"
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditAlertViewController")
        self.present(editVC!, animated: false, completion: nil)
    }
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        contentsLabel.text = "'\(titleLabel)' 목록이 삭제되었습니다."
        deleteButton.isHidden = true
        backButton.isHidden = true
        closeButton.isHidden = false
        dataManager.favoriteDelete(delegate: self, url: "\(Constant.BASE_URL)api/lists/14")
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
       dismiss(animated: false, completion: nil)
       
        
    }
    
}
//MARK: - API
extension DeleteAlertViewController {
    func favoriteDelete(result: FavoriteDeleteResponse) {
        print("\(result.message)")
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
}
