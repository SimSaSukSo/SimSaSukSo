//
//  UploadGeneralThirdStepViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/06.
//

import UIKit
class UploadGeneralThirdStepViewController : UIViewController{
    
    @IBOutlet weak var usedToolButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButton()
    }
    
    func setButton(){
        usedToolButton.te
        usedToolButton.layer.borderWidth = 1
        usedToolButton.layer.borderColor = #colorLiteral(red: 0.9058823529, green: 0.9137254902, blue: 0.9215686275, alpha: 1)
        usedToolButton.layer.cornerRadius = 4
        usedToolButton.sizeToFit()
      
        
        
    }
}
