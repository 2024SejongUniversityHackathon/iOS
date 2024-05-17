//
//  Network.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxCocoa
import RxAlamofire
import RxSwift
import Alamofire
import SwiftKeychainWrapper

final class Network<T: Decodable> {
    private let endpoint : String //서버 엔드포인트
    private let queue : ConcurrentDispatchQueueScheduler //동시성(백그라운드에서 실행)
    init(_ endpoint: String) {
        self.endpoint = endpoint
        self.queue = ConcurrentDispatchQueueScheduler(qos: .background)
    }
    public func getNetwork(path : String) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        
        return RxAlamofire.data(.get, fullpath, headers: ["Content-Type":"Application/json"])
            .observe(on: queue)
            .debug()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    //MARK: - General Post Method
    public func postNetwork(path: String, params: [String:Any]) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        //토큰 유효성 검사
        let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken") ?? ""
        return RxAlamofire.data(.post, fullpath, parameters: params, encoding: JSONEncoding.default, headers: ["Authorization":"\(accessToken)","Content-Type":"Application/json"])
            .observe(on: queue)
            .debug()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
    //MARK: - Auth/Login Method
    public func loginNetwork(path: String, params: [String:Any]) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        return RxAlamofire.data(.post, fullpath, parameters: params, encoding: JSONEncoding.default, headers: ["Content-Type":"Application/json"])
            .observe(on: queue)
            .debug()
            .map { data -> T in
                return try JSONDecoder().decode(T.self, from: data)
            }
    }
}