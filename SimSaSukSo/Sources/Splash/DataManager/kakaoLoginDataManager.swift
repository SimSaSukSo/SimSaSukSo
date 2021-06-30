//
//  kakaoLoginDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/06/30.
//

import Alamofire
class kakaoLoginDataManager{
    func kakaoLogin( accessToken : String, viewcontroller : SplashViewController){
        let parameters : Parameters = [
            "accessToken": accessToken
        ]
        AF.request("\(Constant.BASE_URL)/app/users/kakaoLogin", method: .get,parameters: parameters,encoding: URLEncoding.queryString)
            .validate()
            .responseDecodable(of:kakaoLoginResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                        
                        viewcontroller.success()
                        //viewcontroller2.label_nickname.text = parameters.nickname
                        print("success")
                    }else{
                        
                       
                        //viewcontroller.fail()
                    }
                case .failure(let error):
                    print("fail")
                    print(error.localizedDescription)
                    viewcontroller.fail()
                    
                    
                
                
                }
                
                
                
            }
        
        
        
    }
    
    
    
}
