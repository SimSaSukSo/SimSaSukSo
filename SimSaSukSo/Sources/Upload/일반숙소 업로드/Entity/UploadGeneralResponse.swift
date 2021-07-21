//
//  UploadGeneralResponse.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/21.
//

struct UploadGeneralResponse : Decodable{
        var isSuccess: Bool
        var code: Int
        var message: String
}
