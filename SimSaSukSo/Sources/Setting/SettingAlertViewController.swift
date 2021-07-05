//
//  SettingAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/30.
//

import UIKit

class SettingAlertViewController: UIViewController {
    
    @IBOutlet var settingAlertView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingAlertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    

    @IBAction func noButtonAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func yesButtonAction(_ sender: UIButton) {
        let preVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController")
        
        self.present(preVC!, animated: false, completion: nil)
    }
    
}
