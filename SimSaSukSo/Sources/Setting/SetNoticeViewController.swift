//
//  SetNoticeViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/20.
//

import UIKit

class SetNoticeViewController: UIViewController {

    @IBOutlet var saveButton: UIButton!
    @IBOutlet var noticeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
    }

    
    @IBAction func backButtonAction(_ sender: UIButton) {
        let alertVC = self.storyboard?.instantiateViewController(withIdentifier: "SettingAlertViewController")
        //self.view.backgroundColor?.withAlphaComponent(0.1)
        self.present(alertVC!, animated: false, completion: nil)
        
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        print("저장")
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func pushNoticeSwitchAction(_ sender: UISwitch) {
        if (sender.isOn) {
            print("On")
        } else {
            print("Off")
        }
        
        saveButton.titleLabel?.textColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
    }
    
    @IBAction func allNoticeSwitchAction(_ sender: UISwitch) {
    }
    
    
    
    @IBAction func commentNoticeSwitchAction(_ sender: UISwitch) {
    }
   
    

}
