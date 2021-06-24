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
    

    @IBAction func kakaoLoginButton(_ sender: UIButton) {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoAccount() success.")
                
                //do something
                _ = oauthToken
                // 어세스토큰
                let accessToken = oauthToken?.accessToken
                print("토큰:")
                print(accessToken!)
            }
        }

    }
    
    @IBAction func presentMainButtonTouchUpInside(_ sender: UIButton) {
        let mainTabBarController = UIStoryboard(name: "MainStoryboard", bundle: nil).instantiateViewController(identifier: "ViewController")
        changeRootViewController(mainTabBarController)
    }
}
