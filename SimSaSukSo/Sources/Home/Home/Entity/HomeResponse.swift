//
//  HomeResponse.swift
//  SimSaSukSo
//
//  Created by 이현서 on 2021/07/16.
//

struct  HomeResponse:Decodable {
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : HomeResults
}

struct HomeResults : Decodable{
    var hotPlaces : [hotPlacesDetail]
    var regionName : String
    var regionPlaces : [regionPlacesDetail]
    var trendPlaces : [trendPlacesDetail]
    var likePlaces : [likePlacesDetail]
    var believePlaces : [believePlacesDetail]
    
    
}

struct hotPlacesDetail : Decodable{
    var  feedIndex : Int
    var  source : String
    var  name : String
    
}

struct regionPlacesDetail : Decodable{
    
    var  feedIndex : Int
    var  source : String
    var  name : String
}

struct trendPlacesDetail : Decodable{
    
    var  feedIndex : Int
    var  source : String
    var  name : String
}

struct likePlacesDetail : Decodable{
    
    var  feedIndex : Int
    var  source : String
    var  name : String
}

struct believePlacesDetail : Decodable {
    var  feedIndex : Int
    var  source : String
    var  name : String
    var tags : String
    
}






