//
//  KobisKey.swift
//  EduTemplate - storyboard
//
//  Created by Zero Yoon on 2022/02/23.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가해주세요!!

import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJrYWthb0lkIjoxNzc5NjUzNTEyLCJuaWNrbmFtZSI6IuydtO2YhOyEnCIsImVtYWlsIjoiaHM3MTk4QG5hdmVyLmNvbSIsImlhdCI6MTYyNTY3MTExMiwiZXhwIjoxNjU3MjA3MTEyLCJzdWIiOiJ1c2VySW5mbyJ9.JothGxsDL9yyZ_OeZ9tlHgK1aI9oq4jXONGluX0iCW0"

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
}
