//
//  LoginResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
struct LoginResponseModel : Codable {
    let code : Int
    let state : String
    let message : String?
    let data : LoginData?
}
struct LoginData : Codable {
    let accessToken : String
    let refreshToken : String
}
