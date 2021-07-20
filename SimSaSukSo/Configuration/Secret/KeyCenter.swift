//
//  KobisKey.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가해주세요!!

import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrYWthb0lkIjoxNzk5MTQ4MjA5LCJuaWNrbmFtZSI6IuyalOygleuLmPCfp5rwn4-74oCN4pmA77iPIiwiZW1haWwiOiJnb3N5MzA4QG5hdGUuY29tIiwidXNlckluZGV4IjoyNCwiaWF0IjoxNjI2NTAwNzc2LCJleHAiOjE2NTgwMzY3NzYsInN1YiI6InVzZXJJbmZvIn0.G6xOyxYpL_dwyEAQedm4P7k67NHN4wENaSbRJvdkEOA"

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    
    static let KakaoAuthorization = "KakaoAK b56fd7040b95ad4fa79c575d39fd320b"
    static let kakaoHeader : HTTPHeaders = ["Authorization": "\(KeyCenter.KakaoAuthorization)"]
}
