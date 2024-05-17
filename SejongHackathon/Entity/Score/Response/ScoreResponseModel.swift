//
//  ScoreResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//
import Foundation
struct ScoreResponseModel : Codable {
    let header : ScoreHeader?
    let body : ScoreBody?
}
struct ScoreHeader : Codable {
    let responseCode : Int?
    let status : String?
    let meessage : String?
}
struct ScoreBody : Codable {
    let data : String?
}
