//
//  FavoriteAddResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/20.
//

struct FavoriteAddResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
