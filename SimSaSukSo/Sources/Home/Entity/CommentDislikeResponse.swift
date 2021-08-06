//
//  CommentDislikeResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/06.
//

struct CommentDislikeResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
