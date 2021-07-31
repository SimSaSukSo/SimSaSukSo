//
//  SearchAllResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/01.
//

struct SearchAllResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: SearchAllResult?
}

struct SearchAllResult: Decodable {
    var lodging: [Lodgings]?
    var tag: [Tag]?
}

struct Lodgings: Decodable {
    var generalLodgingIndex: Int
    var name: String
    var locationIndex: Int
    var address: String
}

struct Tag: Decodable {
    var keyword: String
}
