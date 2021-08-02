//
//  WelcomAlertViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/02.
//

import UIKit
class WelcomAlertViewController: UIViewController {
    @IBOutlet var mesaageLabel: UILabel!
    @IBOutlet var evaluAlertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        evaluAlertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    
    
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        let mainController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "TabBarController")
        changeRootViewController(mainController)
      
        self.dismiss(animated: false, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
