//
//  nicknameDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/20.
//

import Alamofire
class nicknameDataManager{
    func nickname(nickname : String, viewcontroller : NicknameViewController ){
        let parameters = ["nickname" : nickname
        ]
        AF.request("\(Constant.BASE_URL)api/users", method: .post,parameters: parameters,encoding: URLEncoding.queryString, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of:nicknameResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                        if response.code == 1000 {
                            print("성공")
                            viewcontroller.success()
                            
                    }
                        
                    }else{
                        print("실패")
                        viewcontroller.nicknameError(message: response.message)
                        print(response.message)
                        print("응답코드: \(response.code)")
                        
                    }
                    
                case .failure(let error):
                    print("서버연결x")
                   
                    print(error.localizedDescription)
                    viewcontroller.fail()
                    
                
                }
                
                
                
            }
        
        
        
    }
    
    
    
}

