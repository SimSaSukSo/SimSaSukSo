//
//  SearchLodgingsResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/01.
//

struct SearchLodgingsResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchLodgingsResult]?
}

struct SearchLodgingsResult: Decodable {
    var generalLodgingIndex: Int
    var name: String
    var locationIndex: Int
    var address: String
}
