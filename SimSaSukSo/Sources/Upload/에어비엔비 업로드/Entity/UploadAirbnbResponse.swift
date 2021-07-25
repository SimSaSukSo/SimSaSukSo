//
//  UploadAirbnbResponse.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/25.
//

struct UploadAirbnbResponse : Decodable{
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : airResults
}

struct airResults : Decodable{
    var type: Int
    var lodgingIndex : Int
}
