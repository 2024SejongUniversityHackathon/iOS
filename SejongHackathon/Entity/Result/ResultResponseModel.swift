//
//  ResultResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//
import Foundation
struct ResultResponseModel : Codable {
    let header : ResultHeader?
    let body : ResultBody?
}
struct ResultHeader : Codable {
    let responseCode : Int?
    let status : String?
    let meessage : String?
}
struct ResultBody: Codable {
    let data: RIASECData
}

struct RIASECData: Codable {
    let r: Int
    let i: Int
    let a: Int
    let s: Int
    let e: Int
    let c: Int
}
