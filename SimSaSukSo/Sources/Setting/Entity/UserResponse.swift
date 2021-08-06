//
//  UserResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/06.
//

struct UserResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: UserResult?
}

struct UserResult: Decodable {
    var email: String
    var nickname: String
    var avatarUrl: String
}
