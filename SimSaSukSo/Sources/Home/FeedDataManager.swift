//
//  FeedDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

import Alamofire

class FeedDataManager {
    
    // 피드 정보 조회
    func feedView(delegate: FeedDetailViewController) {
        let url = "https://dev.enudgu.shop/api/feeds/1"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FeedResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.feedView(result: response.result!)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 피드 댓글 조회
    func feedComment(delegate: FeedDetailViewController) {
        let url = "https://dev.enudgu.shop/api/feeds/1/comments"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FeedCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.feedComment(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
