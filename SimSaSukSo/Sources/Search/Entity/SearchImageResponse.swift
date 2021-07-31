//
//  SearchImageResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

struct SearchImageResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [SearchImageResult]?
}

struct SearchImageResult: Decodable {
    var feedIndex: Int?
    var feedImageIndex: Int?
    var source: String?
}
