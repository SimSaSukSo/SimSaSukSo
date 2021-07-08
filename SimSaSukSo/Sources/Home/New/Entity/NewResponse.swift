//
//  NewResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/08.
//

struct NewResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: NewResult?
}

struct NewResult: Decodable {
    var feeds: [NewFeeds]?
}

struct NewFeeds: Decodable {
    var feedIndex: Int
    var source: String
    var name: String
    var reliability: Int
    var correction: Int
}
