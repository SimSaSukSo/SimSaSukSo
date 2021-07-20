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
        let myFeedNaviVC = self.storyboard?.instantiateViewController(withIdentifier: "MyFeedNavi")
        self.present(myFeedNaviVC!, animated: false, completion: nil)
        
    }
    
    @IBAction func setNoticeButton(_ sender: UIButton) {
        
        let setNoticeVC = self.storyboard?.instantiateViewController(withIdentifier: "SetNoticeViewController")
        self.present(setNoticeVC!, animated: false, completion: nil)
        
    }
    
    @IBAction func profileChangeButton(_ sender: UIButton) {
        
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
        self.present(profileVC!, animated: false, completion: nil)
    }
    
    
}
