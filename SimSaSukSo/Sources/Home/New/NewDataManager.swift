//
//  NewDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/08.
//

import Alamofire

class NewDataManager {
    
    // 최신 - ONE Feed
    func newOneFeed(page: Int , delegate: NewOneFeedViewController) {
        let url = "\(Constant.BASE_URL)api/feeds/new"
        let parameters : Parameters = [
            "page": page
        ]
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: NewResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if page == 1 {
                        delegate.newOneFeed(result: response.result!)
                    } else {
                        delegate.addnewOneFeed(result: response.result!)

                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 최신 - Feeds
    func newFeeds(page : Int ,delegate: NewFeedsViewController) {
        let url = "\(Constant.BASE_URL)api/feeds/new"
        let parameters : Parameters = [
            "page": page
        ]
        AF.request(url, method: .get, parameters: parameters, encoding: URLEncoding.queryString, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: NewResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if page == 1{
                        delegate.newFeeds(result: response.result!)
                    }else{
                        delegate.addnewFeeds(result: response.result!)
                    }
                    
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    
    
    
}
