//
//  FavoriteDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/19.
//

import Alamofire

class FavoriteDataManager {
    
    // 찜 목록 조회
    func favoriteList(delegate: FavoritesViewController) {
        let url = "\(Constant.BASE_URL)api/lists"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FavoriteResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.favoriteLists(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 찜 타이틀 수정
    //func favoriteEdit(_ parameters: FavoriteEditRequest, delegate: )
    

}
