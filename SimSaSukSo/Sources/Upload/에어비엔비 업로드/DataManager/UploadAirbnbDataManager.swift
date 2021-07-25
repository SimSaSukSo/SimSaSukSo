//
//  UploadAirbnbDataManager.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/25.
//

import Alamofire
class UploadAirbnbDataManager{
    func airbnb(parameters:UploadAirbnbInput,viewcontroller:UploadGeneralFifthStepViewController){
        AF.request("\(Constant.BASE_URL)api/feeds/airbnb", method: .post, parameters: parameters,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of:UploadAirbnbResponse.self){response in
                switch response.result{
                case .success(let response):
                    if response.isSuccess{
                        viewcontroller.success()
                        print("성공")
                        
                    }else{
                        print(response.message)
                            
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    viewcontroller.presentAlert(title: "서버와 통신이 불안정합니다")
                    
                }
                
            }
    }
}

