//
//  EvaluFeedbackRequest.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/08.
//

struct EvaluFeedbackRequest: Encodable {
    var feedbacks: [EvaluFeedback]?

}

struct EvaluFeedback: Encodable {
    var feedIndex: Int
    var degree: Int
}
