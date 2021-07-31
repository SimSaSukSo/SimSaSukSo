//
//  UploadCompleteViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/01.
//

import UIKit

class UploadCompleteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func completeButtonAction(_ sender: UIButton) {
        
        let mainStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(identifier: "TabBarController")
        
        self.present(mainVC, animated: false, completion: nil)
    }
    

}
