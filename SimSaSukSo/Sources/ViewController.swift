//
//  ViewController.swift
//  EduTemplate
//
//  Created by 이현서 on 2021/06/17.
//

import Foundation
import UIKit

class ViewController : UIViewController {
    
    @IBOutlet weak var viewforTab: UIView!
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let Home = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "HomeViewController")
        contentView.addSubview(Home.view)
        Home.didMove(toParent: self)
    }
    
    @IBAction func onClickTabBar(_ sender: UIButton) {
        let tag = sender.tag
        print(tag)
        if tag == 1{
            let Home = UIStoryboard(name: "HomeStoryboard", bundle: nil).instantiateViewController(identifier: "HomeViewController")
            contentView.addSubview(Home.view)
            Home.didMove(toParent: self)

            
        }else if tag == 2{
            let Search = UIStoryboard(name: "SearchStoryboard", bundle: nil).instantiateViewController(identifier: "SearchViewController")
            contentView.addSubview(Search.view)
            Search.didMove(toParent: self)
            
        }else if tag == 3{
            let Upload = UIStoryboard(name: "UploadStoryboard", bundle: nil).instantiateViewController(identifier: "UploadViewController")
            contentView.addSubview(Upload.view)
            Upload.didMove(toParent: self)
            
        }else if tag == 4{
            let Favorites = UIStoryboard(name: "FavoritesStoryboard", bundle: nil).instantiateViewController(identifier: "FavoritesViewController")
            contentView.addSubview(Favorites.view)
            Favorites.didMove(toParent: self)
            
        }else{
            let Setting = UIStoryboard(name: "SettingStoryboard", bundle: nil).instantiateViewController(identifier: "SettingViewController")
            contentView.addSubview(Setting.view)
            Setting.didMove(toParent: self)
            
        }

    }
    
}
