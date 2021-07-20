//
//  nicknameViewController.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/21.
//

//

import UIKit
class NicknameViewController : BaseViewController{
    
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var nicknameTextfield: UITextField!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    let toolBar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 60))
    let completeButtonAccessary = UIButton.init(type: .custom)
    
    @IBAction func completeButtonAction(_ sender: UIButton) {
        //안내 라벨 초기화
        checkFormat()
        
        WelcomeAlertView.instance.showAlert(title: "환영합니다 :)", message: "가입이 완료되었습니다.  심사숙소를 통해 쉽고 간편하게 숙소 예약하세요!")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //처음엔 버튼 못쓰게 설정
        completeButton.isEnabled = false
        nicknameTextfield.delegate = self
        
        //텍스트 필드가 validation() 처리할 수 있게 해줌
        NotificationCenter.default.addObserver(self, selector: #selector(validation), name: UITextField.textDidChangeNotification, object: nil)
        
    }
    
    
    //텍스트 필드 채워지면 버튼 활성화
    @objc func validation(){
        let filteredArray = [nicknameTextfield].filter { $0?.text == "" }
        if !filteredArray.isEmpty {
            completeButton.isEnabled = false
            completeButtonAccessary.isEnabled = false
            toolBar.barTintColor = .lightGray
            
            completeButton.backgroundColor = .nicknameGrqy
            completeButtonAccessary.backgroundColor = .nicknameGrqy
        } else {
            toolBar.barTintColor = .simsasuksoGreen
            
            completeButton.isEnabled = true
            completeButtonAccessary.isEnabled = true
            
            completeButton.backgroundColor = .simsasuksoGreen
            completeButtonAccessary.backgroundColor = .simsasuksoGreen
        }
    }
    
    //화면 터치하면 키보드 내려가게
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    
    func checkFormat(){
        
        nicknameDataManager().nickname(nickname: nicknameTextfield.text ?? "", viewcontroller: self)
        
        
        let mainController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "TabBarController")
        changeRootViewController(mainController)
        
    }
    
}

// MARK: Create extension to conform to UITextfieldDelegate
extension NicknameViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        setupTextFieldsAccessoryView()
        return true
    }
    
    func setupTextFieldsAccessoryView() {
        guard nicknameTextfield.inputAccessoryView == nil else {
            print("textfields accessory view already set up")
            return
        }

        // Create toolBar
        
        //toolBar.backgroundColor = .mainOrange
        toolBar.barTintColor = .lightGray
        toolBar.isTranslucent = false
      
                
                
        //완료 버튼
        
        completeButtonAccessary.setTitle("완료", for: .normal)
        completeButtonAccessary.setTitleColor(.white, for: .normal)
    
        completeButtonAccessary.backgroundColor = .clear
        completeButtonAccessary.layer.cornerRadius = 10
        completeButtonAccessary.addTarget(self, action:#selector(doneBtnfromKeyboardClicked), for:.touchUpInside)
        completeButtonAccessary.frame = CGRect.init(x: 0, y: 0, width:50, height: 30)
        
        //UIBarButtonItem에 UIButton을 넣어줌
        
        let barnextButton = UIBarButtonItem.init(customView: completeButtonAccessary)
        
        //toolbar 아이템에 바이전버튼,바다음버튼을 넣어준다.
        toolBar.items = [barnextButton]
        
        nicknameTextfield.inputAccessoryView = toolBar
        
    }
    
    @objc func doneBtnfromKeyboardClicked (){
      // toolBar.barTintColor = .gray
//        emailLabel.text = ""
//        passwordLabel.text = ""
//        checkpassLabel.text = ""
//        phonenumLabel.text = ""
        checkFormat()
        
        self.view.endEditing(true)
        
        checkFormat()
        
    
}
}

extension NicknameViewController{
    
    func success(){
        WelcomeAlertView.instance.showAlert(title: "환영합니다 :)", message: "가입이 완료되었습니다.  심사숙소를 통해 쉽고 간편하게 숙소 예약하세요!")
        
    }
    func nicknameError(message : String){
        nicknameLabel.text = message
    }
    
    func fail(){
        self.presentAlert(title: "서버와 통신이 불안정합니다")
    }
    
    
    
    
    
}
