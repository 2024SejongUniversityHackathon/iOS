//
//  LoginResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
struct LoginResponseModel : Codable {
    let header : loginHeader?
    let body : loginBody
}
struct loginHeader : Codable {
    let responseCode : Int?
    let status : String?
    let message : String?
}
struct loginBody : Codable {
    let data : loginData?
}
struct loginData : Codable {
    let grantType : String?
    let accessToken : String?
    let accessTokenExpiresIn : Double?
}
