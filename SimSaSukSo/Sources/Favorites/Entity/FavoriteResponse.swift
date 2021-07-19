//
//  FavoriteResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/19.
//

struct FavoriteResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: [FavoriteResult]?
}

struct FavoriteResult: Decodable {
    var savedListIndex: Int
    var title: String
    var sources: Array<String>
}
