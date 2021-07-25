//
//  FeedResponse.swift
//  SimSaSukSo
//
//  Created by 소영 on 2021/07/25.
//

struct FeedResponse: Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result: FeedResult?
}

struct FeedResult: Decodable {
    var feedImage: [FeedImage]?
    var feedLike: FeedLike
    var correction: Correction
    var save: Save?
    var prosAndCons: [ProsAndCons]
    var feedInfo: FeedInfo
    var lodgingInfo: LodgingInfo
}

struct FeedImage: Decodable {
    var feedImageIndex: Int
    var source: String
    var uploadOrder: Int
}

struct FeedLike: Decodable {
    var likeNum: Int
    var isLiked: Int
}

struct Correction: Decodable {
    var correctionToolIndex: String
    var correctionTool: String
    var correctionDegree: Int
}

struct Save: Decodable {
    var saveNum: Int // 찜 개수
    var isSaved: Int // 찜 여부
}

struct ProsAndCons: Decodable { // 장단점
    var satus: String
    var keyword: String
}

struct FeedInfo: Decodable {
    var review: String
    var charge: Int
    var startDate: String //
    var endDate: String //
    var createdAt: String //
    var reliability: Int
    var hashTags: String // 배열로 수정
}

struct LodgingInfo: Decodable {
    var airbnbIndex: Int
    var url: String
    var description: String
    
    var generalLodgingIndex: Int
    var name: String
    var address: String
}
