//
//  FavoriteDetailResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/20.
//

struct FavoriteDetailResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: FavoriteDetailResult?
}

struct FavoriteDetailResult: Decodable {
    var title: String
    var feeds: [FavoriteDetailFeeds]?
}

struct FavoriteDetailFeeds: Decodable {
    var feedIndex: Int
    var source: String
}
