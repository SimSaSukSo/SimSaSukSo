//
//  EvaluResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

struct EvaluResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [EvalueResult]?
}

struct EvalueResult: Decodable {
    var feedIndex: Int
    var avatarUrl: String
    var nickname: String
    var sources: Array<String>
}
