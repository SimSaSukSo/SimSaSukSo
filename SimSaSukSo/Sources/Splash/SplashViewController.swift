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
import AuthenticationServices

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
    
    


    @IBAction func handleSignInButton(sender : UIButton){
        
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName,.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self as? ASAuthorizationControllerDelegate
        controller.presentationContextProvider = self as? ASAuthorizationControllerPresentationContextProviding
        controller.performRequests()
        
    }
    

}

extension SplashViewController : ASAuthorizationControllerDelegate{
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //성공 후 동작
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
                // Create an account in your system.
                let userIdentifier = appleIDCredential.user
                let userFirstName = appleIDCredential.fullName?.givenName
                let userLastName = appleIDCredential.fullName?.familyName
                let userEmail = appleIDCredential.email
                let jwt = appleIDCredential.identityToken
                
                
                print(userIdentifier)
                print(userFirstName)
                print(userLastName)
                print(userEmail)
                print(jwt?.base64EncodedString())
         
            let input : appleLoginInput = appleLoginInput(accessToken: (jwt?.base64EncodedString())!)
               
                appleLoginDataManager().appleLogin(parameters: input, viewcontroller: self)
               
                
                
            } else if let passwordCredential = authorization.credential as? ASPasswordCredential {
                // Sign in using an existing iCloud Keychain credential.
                let username = passwordCredential.user
                let password = passwordCredential.password
                
                print(username)
                print(password)
                //Navigate to other view controller 
            }


    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        //실패 후 동작
        print("실패")
    }
    
    
    
}
