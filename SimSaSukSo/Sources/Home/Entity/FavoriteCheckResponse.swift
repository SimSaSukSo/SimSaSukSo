//
//  FavoriteCheckResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

struct FavoriteCheckResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
