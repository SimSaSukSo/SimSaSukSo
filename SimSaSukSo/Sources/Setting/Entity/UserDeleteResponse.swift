//
//  UserDeleteResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/08/01.
//

struct UserDeleteResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
