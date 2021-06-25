//
//  ExitAlertView.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/06/25.
//

import UIKit

class ExitAlertView: UIView {
    
    static let instance = ExitAlertView()
    
   
    @IBOutlet var topView: UIView!
    @IBOutlet var exitAlertView: UIView!
    @IBOutlet var exitTitleLabel: UILabel!
    @IBOutlet var exitMessageLabel: UILabel!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
        Bundle.main.loadNibNamed("WelcomeAlertView", owner: self, options: nil)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit(){
        
        exitAlertView.layer.cornerRadius = 4
        topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height
        )
        topView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
    }
    
    func showAlert(title : String, message: String){
        self.exitTitleLabel.text = title
        self.exitMessageLabel.text = message
        
        
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.addSubview(topView)
    }
    
    
    @IBAction func noButtonAction(_ sender: UIButton) {
        print("나가")
    }
    
    @IBAction func startButtonAction(_ sender: UIButton) {
        print("시작")
    }
    
}
