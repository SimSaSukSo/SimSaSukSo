//
//  EditCommentRequest.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/08/09.
//

import UIKit
struct EditCommentRequest : Encodable{
    var content : String
    var commentIndex : Int
}
