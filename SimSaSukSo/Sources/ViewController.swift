//
//  ViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//


import UIKit



class ViewController : UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTabBarBackgroundColor()
        setTabBarTextColor()
        
        
       
        
   }
    
    
    
    func setTabBarBackgroundColor() {
        self.tabBar.barTintColor = .white
        self.tabBar.backgroundColor = .white
        self.tabBarController?.view.backgroundColor = .white
        self.tabBar.isTranslucent = false        }
    
    func setTabBarTextColor(){
        // 기본적인 tabBar의 글자색을 지정해준다.
        self.tabBar.tintColor = UIColor(hex: 0x222222)
        
        //tabBar가 선택되지 않았을때의 색을 지정해준다.
        self.tabBar.unselectedItemTintColor = UIColor(hex: 0xA6B0BA)
        
    }
    
   

}



       
