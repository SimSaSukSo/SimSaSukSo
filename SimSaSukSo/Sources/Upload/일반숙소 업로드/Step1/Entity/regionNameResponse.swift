//
//  File.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/18.
//
struct regionNameResponse : Decodable{
    
    var documents : [documentsDetail]
    var meta : metaDetail
    }

struct documentsDetail : Decodable{
    
    var address_name : String
    var category_group_code : String
    var category_group_name : String
    var category_name : String
    var distance : String
    var id : String
    var phone : String
    var place_name : String
    var place_url : String
    var road_address_name : String
    var x : String
    var y : String
    
    
}

struct metaDetail : Decodable{
    
    var  is_end : Bool
    var  pageable_count : Int
    var   same_name : same_nameDetail
    var total_count : Int
    
    
}

struct same_nameDetail : Decodable{
    var keyword : String
    var region: [String]
    var selected_region : String
    
}
        
        
 
