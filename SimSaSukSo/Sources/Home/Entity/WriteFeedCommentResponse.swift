//
//  WriteCommentResponse.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/30.
//

struct WriteFeedCommentResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
