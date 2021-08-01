//
//  SearchTagImageResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/02.
//

struct SearchTagImageResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchTagImageResult]?
}

struct SearchTagImageResult: Decodable {
    var feedIndex: Int
    var feedImageIndex: Int
    var source: String
}
