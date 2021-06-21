//
//  ProfileViewController.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/20.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var userProfileImageView: UIImageView!
    @IBOutlet var cameraButton: UIButton!
    @IBOutlet var userNicknameLabel: UILabel!
    @IBOutlet var userEmailLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.height/2
        
        cameraButton.layer.cornerRadius = cameraButton.frame.size.height/2
        cameraButton.layer.shadowColor = UIColor.lightGray.cgColor
        cameraButton.layer.shadowOffset = CGSize(width: 3, height: 3)
        cameraButton.layer.shadowOpacity = 0.2
        cameraButton.layer.shadowRadius = 0.8
    }
    

    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButtonAction(_ sender: UIButton) {
        if cameraButton.isSelected {
            saveButton.titleLabel?.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
    }
    
    @IBAction func cameraButtonAction(_ sender: UIButton) {
    }
    
    
}
