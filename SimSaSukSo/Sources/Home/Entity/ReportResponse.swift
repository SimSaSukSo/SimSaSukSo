//
//  ReportResponse.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/05.
//

struct ReportResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
}
