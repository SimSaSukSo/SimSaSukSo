//
//  regionNameDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/18.
//

import Alamofire
class regionNameDataManager{
    func regionName (keyword : String,viewcontroller : UploadGeneralFirstStepViewController){
        let parameters : Parameters = [
            "query": keyword,
            "category_group_code" : "AD5"
        ]
        AF.request("https://dapi.kakao.com/v2/local/search/keyword.json?", method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: KeyCenter.kakaoHeader)
            .validate()
            .responseDecodable(of:regionNameResponse.self){response in
                switch response.result{
                case .success(let response):
                   
                        viewcontroller.success(result: response.documents)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                  
                    viewcontroller.presentAlert(title: "서버와 통신이 불안정합니다")
                    
                
                
                }
                
                
                
            }
        
        
        
    }
    
    
    
}


