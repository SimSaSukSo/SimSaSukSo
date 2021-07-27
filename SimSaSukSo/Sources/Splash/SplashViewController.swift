//
//  SplashViewController.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon


class SplashViewController: BaseViewController {
    

    
    @IBOutlet weak var appleImage: UIImageView!
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        appleImage.layer.cornerRadius = appleImage.frame.size.height / 2
        appleImage.backgroundColor = UIColor.black
        
       
       
        
    }
    @IBAction func appleLoginButton(_ sender: Any) {
       
    }
    @IBAction func kakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                let accessToken = oauthToken?.accessToken
                
                self.showIndicator()
                let input : kakaoLoginInput = kakaoLoginInput(accessToken: accessToken!)
                
                print("토큰:")
                print(accessToken!)
                
                kakaoLoginDataManager().kakaoLogin(parameters: input, viewcontroller: self)
                
                print("토큰:")
                print(accessToken!)
              
                
                _ = oauthToken
                // 어세스토큰
                
                
                
            }
        }

    }
    
    func SignUpSuceess(){
        //회원가입 성공 -> 닉네임 작성 화면 이동
        let nickNameController = UIStoryboard(name: "SplashStoryboard", bundle: nil).instantiateViewController(identifier: "NicknameViewController")
        changeRootViewController(nickNameController)
    }
    
    func LoginSuceess(jwt : String){
        //로그인 성공 -> 메인 화면 이동
        KeyCenter.LOGIN_TOKEN = jwt
        let mainController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "TabBarController")
        changeRootViewController(mainController)
        
    }
    
    func fail(){
        self.presentAlert(title: "서버와 통신이 불안정합니다")
    }
    
   
}
