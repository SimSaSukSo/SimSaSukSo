//
//  AddAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/12.
//

import UIKit

class AddAlertViewController: UIViewController {
    
    let favoritesViewController = FavoritesViewController()

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
        dismiss(animated: false, completion: nil)
    }
    

}
