//
//  UploadAlertViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/06.
//

import UIKit

class UploadAlertViewController: UIViewController {
    
    let uploadViewController = UploadViewController()
    
    @IBOutlet var uploadAlertView: UIView!
    @IBOutlet var stackView: UIStackView!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var airButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uploadAlertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        normalButton.layer.borderWidth = 0.5
        normalButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
        airButton.layer.borderWidth = 0.5
        airButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
    
    }
    
    @IBAction func normalButtonAction(_ sender: UIButton) {
        normalButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        normalButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
        normalButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
       
        
        airButton.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1)
        airButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        airButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
    }
    @IBAction func airButtonAction(_ sender: UIButton) {
        airButton.tintColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
        airButton.backgroundColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 0.1)
        airButton.layer.borderColor = #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1)
       
        
        normalButton.tintColor = #colorLiteral(red: 0.2509803922, green: 0.2823529412, blue: 0.3058823529, alpha: 1)
        normalButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        normalButton.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.8352941176, blue: 0.8549019608, alpha: 1)
        
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    @IBAction func chooseButtonAction(_ sender: UIButton) {
        
        if normalButton.tintColor == #colorLiteral(red: 0, green: 0.8431372549, blue: 0.6705882353, alpha: 1) {
            let normalVC = self.storyboard?.instantiateViewController(identifier: "UploadGeneralFirstStepViewController")
            
            self.present(normalVC!, animated: false, completion: nil)
            print(UploadViewController.photoArray.count)
            print(UploadViewController.urlArray.count)
            print(UploadViewController.urlArray.description)
        } else {
            print("에어비앤비로")
            let airVC = self.storyboard?.instantiateViewController(identifier: "UploadAirbnbFirstStepViewController")
            
            self.present(airVC!, animated: false, completion: nil)
        
        }
        
    }
    
    
}
