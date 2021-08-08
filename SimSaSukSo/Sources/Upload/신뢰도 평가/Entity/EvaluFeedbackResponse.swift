//
//  EvaluFeedbackResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/08.
//

struct EvaluFeedbackResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: EvaluFeedbackResult?
}

struct EvaluFeedbackResult: Decodable {
    var count: Int
}
