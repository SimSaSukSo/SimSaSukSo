//
//  ViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import Foundation
import UIKit

class ViewController : UITabBarController {
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarBackgroundColor()
        
   }
    
    func setTabBarBackgroundColor() {
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBarController?.view.backgroundColor = .white
        self.tabBar.isTranslucent = false        }

}
