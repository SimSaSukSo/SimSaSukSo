//
//  EvaluDataManager.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

import Alamofire

class EvaluDataManager {
    // 신뢰도 평가하기 항목 조회
    func evaluView(type: Int, lodgingIndex: Int, delegate: EvaluViewController) {
        let url = "\(Constant.BASE_URL)api/feedbacks?type=\(type)&lodging=\(lodgingIndex)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: EvaluResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.evaluView(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 신뢰도 평가하기 항목 조회 - ImageCell
    func evaluView(type: Int, lodgingIndex: Int, delegate: EvaluCollectionViewCell) {
        let url = "\(Constant.BASE_URL)api/feedbacks?type=\(type)&lodging=\(lodgingIndex)"
        AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: EvaluResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.evaluView(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    // 신뢰도 평가하기 작성
        func evaluFeedback(_ parameters: EvaluFeedbackRequest, delegate: EvaluViewController) {
            AF.request("\(Constant.BASE_URL)api/feedbacks", method: .post, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
                .validate()
                .responseDecodable(of: EvaluFeedbackResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        delegate.evaluFeedback(response)
                    case .failure(let error):
                        print(error.localizedDescription)
                        delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                    }
                }
        }
}
