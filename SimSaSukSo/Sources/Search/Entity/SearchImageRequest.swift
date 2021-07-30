//
//  SearchImageRequest.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/30.
//

struct SearchImageRequest: Encodable {
    var pros: [Int]
    var cons: [Int]
    var minPrice: Int
    var maxPrice: Int
    var locationIdx: Int
    var interval: String
}
