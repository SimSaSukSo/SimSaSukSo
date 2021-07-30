//
//  FeedLikeResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

struct FeedLikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
