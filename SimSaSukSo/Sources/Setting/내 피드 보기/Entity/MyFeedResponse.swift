//
//  MyFeedResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/17.
//

struct MyFeedResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: MyFeedResult?
}

struct MyFeedResult: Decodable {
    var feedImage: [feedImage]?
    var feedLike: feedLike?
    var correction: correction?
    var save: save?
    var prosAndCons: [prosAndCons]?
    var feedInfo: feedInfo?
    var lodgingInfo: lodgingInfo?
}

struct feedImage: Decodable {
    var feedImageIndex: Int
    var source: String
    var uploadOrder: Int
}

struct feedLike: Decodable {
    var likeNum: Int
    var isLiked: Int
}

struct correction: Decodable {
    var correctionToolIndex: String
    var correctionTool: String
    var correctionDegree: Int
}

struct save: Decodable {
    var saveNum: Int // 찜 개수
    var isSaved: Bool // 찜 여부
}

struct prosAndCons: Decodable {
    var satus: String
    var keyword: String
}

struct feedInfo: Decodable {
    var review: String
    var charge: Int
    var startDate: String //
    var endDate: String //
    var createdAt: String //
    var reliability: Float
    var hashTags: String // 배열로 수정
}

struct lodgingInfo: Decodable {
    var airbnbIndex: Int
    var url: String
    var description: String
    
    var generalLodgingIndex: Int
    var name: String
    var address: String
}


