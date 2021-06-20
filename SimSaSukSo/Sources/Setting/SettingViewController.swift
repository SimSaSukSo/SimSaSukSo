//
//  SettingViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class SettingViewController : UIViewController {

    @IBOutlet var settingStackView: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    
    
    @IBAction func myFeedButton(_ sender: UIButton) {
        
    }
    
    @IBAction func setNoticeButton(_ sender: UIButton) {
        
        let setNoticeVC = self.storyboard?.instantiateViewController(withIdentifier: "SetNoticeViewController")
        setNoticeVC?.modalPresentationStyle = .fullScreen
        self.present(setNoticeVC!, animated: true, completion: nil)
        
    }
    
    @IBAction func profileChangeButton(_ sender: UIButton) {
        
    }
    
    
}
