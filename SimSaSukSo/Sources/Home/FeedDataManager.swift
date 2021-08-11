//
//  FeedDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

import Alamofire

class FeedDataManager {
    
    // 피드 정보 조회
    func feedView(delegate: FeedDetailViewController, url: String) {
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FeedResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.result == nil{
                        delegate.feedDefaultValue()
                    }else{
                        delegate.feedView(result: response.result!)
                    }
                   
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 피드 댓글 조회
    func feedComment(url : String, delegate: FeedDetailViewController) {
        
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FeedCommentResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.result == nil{
                        delegate.commentDefaultValue()
                    }else{
                        delegate.feedComment(result: response)}
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //피드 댓글 작성
    func writeFeedComment(text : String ,url : String , delegate: FeedDetailViewController) {
            
            let body = ["content" : text]
            AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: KeyCenter.header)
                .validate()
                .responseDecodable(of: WriteFeedCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        delegate.writeFeedComment(result: response)
                    case .failure(let error):
                        print(error.localizedDescription)
                        delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                    }
                }
        }
    
    //피드 댓글 수정
    func editComment(feedIndex : Int, editCommentInput : EditCommentRequest , delegate: FeedDetailViewController) {
        AF.request("\(Constant.BASE_URL)api/feeds/\(feedIndex)/comments", method: .put, parameters: editCommentInput, headers: KeyCenter.header)
                .validate()
                .responseDecodable(of: WriteFeedCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.isSuccess == true{
                            print(response.message)
                            delegate.editFeedComment(result: response)
                        }else{
                            delegate.failedToRequest(message: response.message)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                    }
                }
        }
    
    
    //피드 댓글 삭제
    func deleteComment(feedIndex : Int, commentIndex : Int, delegate: FeedDetailViewController) {
            
            let body = ["commentIndex" : commentIndex]
            AF.request("\(Constant.BASE_URL)api/feeds/\(feedIndex)/comments", method: .delete, parameters: body, encoding: JSONEncoding.default, headers: KeyCenter.header)
                .validate()
                .responseDecodable(of: WriteFeedCommentResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        if response.isSuccess == true{
                            print(response.message)
                            delegate.deleteFeedComment(result: response)
                        }else{
                            delegate.failedToRequest(message: response.message)
                        }
                       
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                    }
                }
        }
    
    // 피드 찜하기-해제
    func favoriteCheck(_ parameters: FavoriteCheckRequest, delegate: FeedFavoriteAlertViewController) {
        AF.request("\(Constant.BASE_URL)api/saved-feeds", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FavoriteCheckResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.favoriteCheck(response)
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 피드 좋아요
    func likeCheck(_ parameters: FeedLikeRequest, delegate: FeedDetailViewController, url: String) {
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FeedLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.likeCheck(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 피드 좋아요 취소
    func dislikeCheck(_ parameters: FeedLikeRequest, delegate: FeedDetailViewController, url: String) {
        AF.request(url, method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: FeedDislikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.dislikeCheck(response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //피드 신고하기
    func report(idx : Int, delegate: FeedDetailViewController) {
        let url = "\(Constant.BASE_URL)api/feeds/\(idx)/report"
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: ReportResponse.self) { response in
                switch response.result {
                case .success(let response):
                    if response.isSuccess == true{
                        delegate.report(result: "신고 접수가 정상적으로 처리되었습니다.")
                        
                    }else if response.code == 3010{
                        delegate.report(result: "신고 접수가 정상적으로 처리되었습니다.")
                    }else{
                        delegate.report(result: response.message)
                    }
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 댓글 좋아요
    func commentLikeCheck(delegate: FeedCommentTableViewCell, url: String) {
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: CommentLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.commentLikeCheck(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 댓글 좋아요 취소
    func commentdislikeCheck(delegate: FeedCommentTableViewCell, url: String) {
        AF.request(url, method: .post, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: CommentDislikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.commentDislikeCheck(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
}
