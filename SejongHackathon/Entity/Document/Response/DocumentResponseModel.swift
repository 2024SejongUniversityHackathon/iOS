//
//  DocumentResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
struct DocumentResponseModel : Codable {
    let header : documentHeader?
    let body : documentBody?
}
struct documentHeader : Codable {
    let responseCode : Int?
    let status : String?
    let meessage : String?
}
struct documentBody : Codable {
    let data : String?
}
