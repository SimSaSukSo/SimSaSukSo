//
//  UploadGeneralInput.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/21.
//

struct UploadGeneralInput : Encodable{
    var name : String
    var images  : [String]
    var address : String
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
