//
//  HomeResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
struct HomeResponseModel : Codable {
    let header : HomeHeader?
    let body : HomeBody?
}
struct HomeHeader : Codable {
    let responseCode : Int?
    let status : String?
    let meessage : String?
}
struct HomeBody : Codable {
    let data : Bool?
}
