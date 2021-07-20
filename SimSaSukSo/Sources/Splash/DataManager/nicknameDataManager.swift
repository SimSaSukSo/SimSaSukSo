//
//  nicknameDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/20.
//

import Alamofire
class nicknameDataManager{
    func nickname(nickname : String, viewcontroller : NicknameViewController ){
       
        AF.request("\(Constant.BASE_URL)api/users", method: .post,parameters: nickname,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of:nicknameResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                        print(response.code)
                        if response.code == 2001 || response.code == 2002 || response.code == 2003 {
                        
                            viewcontroller.nicknameError(message: response.message)
                            
                        }else if response.code == 1000{
                            
                            viewcontroller.success()
                        }
                        
                    }else{
                       print(response.message)
                       
                    }
                case .failure(let error):
                    print("서버연결x")
                   
                    print(error.localizedDescription)
                    viewcontroller.fail()
                    
                
                }
                
                
                
            }
        
        
        
    }
    
    
    
}

