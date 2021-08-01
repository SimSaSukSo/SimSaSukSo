//
//  SettingViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import UIKit

class SettingViewController : UIViewController {
    
    lazy var dataManager = SettingDataManager()

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
    @IBAction func logoutButtonAction(_ sender: UIButton) {
        let logoutAlert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .default, handler: {(action) in self.logout()})
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: .none)
        
        logoutAlert.addAction(yesAction)
        logoutAlert.addAction(noAction)
        
        present(logoutAlert, animated: true, completion: nil)
    }
    
    @IBAction func userDeleteButtonAction(_ sender: UIButton) {
        let userDeleteAlert = UIAlertController(title: "회원 탈퇴", message: "회원을 탈퇴하시겠습니까?", preferredStyle: .alert)
        
        let yesAction = UIAlertAction(title: "네", style: .destructive, handler: {(action) in self.userDeleteAction()})
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: .none)
        
        userDeleteAlert.addAction(yesAction)
        userDeleteAlert.addAction(noAction)
        
        present(userDeleteAlert, animated: true, completion: nil)

    }
    
    
    
}

//MARK: - API
extension SettingViewController {
    func userDelete(result: UserDeleteResponse) {
        self.presentAlert(title: "회원탈퇴 성공")
        let splashStoryboard = UIStoryboard.init(name: "SplashStoryboard", bundle: nil)
        
        let splashVC = splashStoryboard.instantiateViewController(identifier: "SplashViewController") as! SplashViewController
        
        self.changeRootViewController(splashVC)
    }
    
    func failedToRequest(message: String) {
        self.presentAlert(title: message)
    }
    
    func userDeleteAction() {
        dataManager.userDelete(delegate: self)
        
    }
    
    func logout() {
        print("로그아웃")
    }
}
