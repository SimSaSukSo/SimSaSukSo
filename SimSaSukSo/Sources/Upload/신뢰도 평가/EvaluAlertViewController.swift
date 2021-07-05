//
//  EvaluAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/05.
//

import UIKit

class EvaluAlertViewController: UIViewController {

    @IBOutlet var mesaageLabel: UILabel!
    @IBOutlet var evaluAlertView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        evaluAlertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    
    @IBAction func goHomeButtonAction(_ sender: UIButton) {
        let mainStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        let mainVC = mainStoryboard.instantiateViewController(identifier: "TabBarController")
        
        //self.changeRootViewController(homeVC)
        self.present(mainVC, animated: false, completion: nil)
        
    }
    @IBAction func stayButtonAction(_ sender: UIButton) {
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
