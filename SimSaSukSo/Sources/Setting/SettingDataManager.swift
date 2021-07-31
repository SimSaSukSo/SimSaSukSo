//
//  SettingDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/01.
//

import Alamofire

class SettingDataManager {
    // 프로필 사진 변경
    func profileImage(_ parameters: ProfileImageRequest, delegate: ProfileViewController, url: String) {
        AF.request(url, method: .put, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: ProfileImageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.profileImage(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
