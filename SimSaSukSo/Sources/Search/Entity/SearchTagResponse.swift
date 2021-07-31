//
//  SearchTagResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/01.
//

struct SearchTagResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchTagResult]?
}

struct SearchTagResult: Decodable {
    var keyword: String
}
