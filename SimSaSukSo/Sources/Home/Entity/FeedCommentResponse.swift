//
//  FeedCommentResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

struct FeedCommentResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [FeedCommentResult]?
}

struct FeedCommentResult: Decodable {
    var commentIndex: Int
    var userIndex: Int
    var nickname: String
    var avatarUrl: String
    var content: String
    var createdAt: String
    var updatedAt: String
    var likeNum: Int
}
