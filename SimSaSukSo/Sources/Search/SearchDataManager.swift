//
//  SearchDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

import Alamofire

class SearchDataManager {
    // 이미지 검색
    func searchImage(_ parameters: SearchImageRequest, delegate: SearchResultViewController) {
        AF.request("https://dev.enudgu.shop/api/feeds/search/origin", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: SearchImageResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.searchImage(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 전체 검색
    func searchAll(delegate: SearchAllTableViewController, url: String) {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: SearchAllResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.searchAll(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
