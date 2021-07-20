//
//  HomeDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/16.
//

import Alamofire
class HomeDataManager{
    func home (region : Int,viewcontroller : HomeTabViewController){
        let parameters : Parameters = [
            "region": region
        ]
        AF.request("\(Constant.BASE_URL)api/feeds/home", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of:HomeResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                       
                        viewcontroller.success(result: response.result)
                       
                       
                    }else{
                        viewcontroller.fail()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                  
                    viewcontroller.presentAlert(title: "서버와 통신이 불안정합니다")
                    
                
                
                }
                
                
                
            }
        
        
        
    }
    
    
    
}

