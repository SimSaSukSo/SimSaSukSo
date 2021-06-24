//
//  SplashViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit

class SplashViewController: BaseViewController {
    
    @IBAction func presentMainButtonTouchUpInside(_ sender: UIButton) {
        let mainTabBarController = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(identifier: "SettingViewController")
        changeRootViewController(mainTabBarController)
    }
}
