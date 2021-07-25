//
//  UploadAirbnbInput.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/25.
//

struct UploadAirbnbInput : Encodable{
    var locationId : Int
    var images  : [String]
    var description : String
    var url : String
    var startDate: String
    var endDate : String
    var charge : Int
    var correctionTool : [Int]
    var correctionDegree : Int
    var review : String
    var tags : [String]
    var pros : [String]
    var cons : [String]
}
