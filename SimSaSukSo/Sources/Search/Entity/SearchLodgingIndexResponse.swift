//
//  SearchLodgingIndexResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/01.
//

struct SearchLodgingIndexResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchLodgingIndexResult]?
}

struct SearchLodgingIndexResult: Decodable {
    var feedIndex: Int
    var feedImageIndex: Int
    var source: String?
}
