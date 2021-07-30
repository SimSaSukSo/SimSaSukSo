//
//  BestResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/08.
//

struct BestResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: BestResult?
}

struct BestResult: Decodable {
    var hashTags: [BestHashTags]?
    var feeds: [BestFeeds]?
    var isLast : Bool
}

struct BestHashTags: Decodable {
    var keyword: String
    var source: String
}

struct BestFeeds: Decodable {
    var feedIndex: Int
    var source: String
    var name: String
    var reliability: Int // 신뢰도
    var degree: Int // 보정 정도
}
