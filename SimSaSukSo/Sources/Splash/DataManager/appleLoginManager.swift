//
//  appleLoginManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/30.
//

import Alamofire

class appleLoginDataManager{
    func appleLogin(parameters:appleLoginInput, viewcontroller : SplashViewController){
       
        AF.request("\(Constant.BASE_URL)api/users/appleLogin", method: .post,parameters: parameters)
            .validate()
            .responseDecodable(of:appleLoginResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                        print(response.code)
                        if response.code == 1001{
                            //로그인
                            print("로그인 성공")
                            viewcontroller.LoginSuceess(jwt: response.token!)
                            print(response.token!)
                        }else if response.code == 1000{
                            //회원 가입
                            viewcontroller.SignUpSuceess(jwt: response.token!)
                            print(response.token!)
                            print("회원가입")
                        }
                        
                    }else{
                        
                       print("failed")
                    
                        viewcontroller.presentAlert(title: response.message)
                        //viewcontroller.fail()
                    }
                case .failure(let error):
                    print("서버연결x")
                   
                    print(error.localizedDescription)
                    viewcontroller.fail()
                    
                    
                
                
                }
                
                
                
            }
        
        
        
    }
    
    
    
}

