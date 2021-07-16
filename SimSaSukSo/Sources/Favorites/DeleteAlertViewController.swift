//
//  DeleteAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/16.
//

import UIKit

class DeleteAlertViewController: UIViewController {
    
    let editVC = EditAlertViewController()
    
    @IBOutlet var alertView: UIView!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var backButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        alertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        //closeButton.isHidden = true
    }
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
        let editVC = self.storyboard?.instantiateViewController(withIdentifier: "EditAlertViewController")
        self.present(editVC!, animated: false, completion: nil)
    }
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        contentsLabel.text = "‘친구들이랑 호캉스’ 목록이 삭제되었습니다."
        deleteButton.isHidden = true
        backButton.isHidden = true
        closeButton.isHidden = false
    }
    @IBAction func closeButtonAction(_ sender: UIButton) {
       dismiss(animated: false, completion: nil)
        
    }
    
}
