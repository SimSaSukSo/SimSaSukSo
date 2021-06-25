//
//  WelcomAlertView.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/23.
//

import Foundation
import UIKit

class WelcomeAlertView: UIView{
    
    static let instance = WelcomeAlertView()
    
    @IBOutlet var parentView: UIView!
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        Bundle.main.loadNibNamed("WelcomeAlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        
        alertView.layer.cornerRadius = 4
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height
        )
        parentView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func showAlert(title : String, message: String){
        self.titleLabel.text = title
        self.messageLabel.text = message
        
        
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(parentView)
    }
    
    
    
    @IBAction func startButtonAction(_ sender: Any) {
        parentView.removeFromSuperview()
    }
    
}
