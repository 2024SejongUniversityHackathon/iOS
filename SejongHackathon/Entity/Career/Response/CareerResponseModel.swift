//
//  CareerResponseModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
struct CareerResponseModel : Codable {
    let count : Int?
    let pageSize : Int?
    let pageIndex : Int?
    let jobs : [CareerJobs]?
}
struct CareerJobs : Codable {
    let aptit_name : String?
    let work : String?
    let job_cd: Int?
    let rel_job_nm: String?
    let job_nm : String?
    let wlb : String?
    let RNUM : Int?
    let edit_dt : Double?
    let reg_dt : Double?
    let views : Int?
    let likes : Int?
    let wage : String?
}
