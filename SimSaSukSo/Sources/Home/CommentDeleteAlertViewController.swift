//
//  CommentDeleteAlertViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/08.
//

import UIKit

class CommentDeleteAlertViewController: UIViewController {
    
    var delegate: commentDeleteDelegate?
    
    @IBOutlet var settingAlertView: UIView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var noButton: UIButton!
    @IBOutlet var yesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingAlertView.layer.cornerRadius = 4
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
    }
    

    @IBAction func noButtonAction(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
    }
    @IBAction func yesButtonAction(_ sender: UIButton) {
        
        delegate?.commentDeleteDelegate()
        self.dismiss(animated: false, completion: nil)
    
}
}
