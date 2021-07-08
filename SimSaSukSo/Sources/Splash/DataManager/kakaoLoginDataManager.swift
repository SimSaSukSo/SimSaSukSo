//
//  kakaoLoginDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/30.
//

import Alamofire
class kakaoLoginDataManager{
    func kakaoLogin(parameters:kakaoLoginInput, viewcontroller : SplashViewController){
       
        AF.request("\(Constant.BASE_URL)api/users/kakaoLogin", method: .post,parameters: parameters)
            .validate()
            .responseDecodable(of:kakaoLoginResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                        print("success")
                        viewcontroller.success()
                        //viewcontroller2.label_nickname.text = parameters.nickname
                       
                    }else{
                        
                       print("failed")
                     print(response.message)
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
