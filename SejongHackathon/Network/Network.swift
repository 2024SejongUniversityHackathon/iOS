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
    //MARK: - General Get Method
    public func getNetwork(path : String) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        
        let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken") ?? ""
        return Observable.create { observer in
            AF.request(fullpath, method: .get, headers: ["Contetn-Type":"application/json","Authorization":"\(accessToken)"])
            .responseDecodable(of: T.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    //MARK: - General Post Method
    public func postNetwork(path: String, params: [String:Any]) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        //토큰 유효성 검사
        let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken") ?? ""
        return Observable.create { observer in
            AF.request(fullpath, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Contetn-Type":"application/json","Authorization":"\(accessToken)"])
            .responseDecodable(of: T.self) { response in
                print(response.debugDescription)
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    //MARK: - Auth/Login Method
    public func loginNetwork(path: String, params: [String:Any]) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        return Observable.create { observer in
            AF.request(fullpath, method: .post, parameters: params, encoding: JSONEncoding.default, headers: ["Contetn-Type":"application/json"])
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    //MARK: - OpenAPI
    public func OpenApiNetwork(path : String) -> Observable<[T]> {
        let fullpath = "\(path)"
        
        return Observable.create { observer in
            AF.request(fullpath, method: .get, headers: ["Contetn-Type":"application/json"])
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext([data])
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    //MARK: - MultipartFormData Method
    public func formDataNetwork(path: String, data : Data, fileName : String) -> Observable<T> {
        let fullpath = "\(endpoint)\(path)"
        //토큰 유효성 검사
        let accessToken = KeychainWrapper.standard.string(forKey: "JWTaccessToken") ?? ""
        return Observable.create { observer in
            AF.upload(multipartFormData: { formData in
                formData.append(data, withName: "file", fileName: "\(fileName).pdf", mimeType: "file/pdf")
            }, to: fullpath, method: .post, headers:  ["Authorization":"\(accessToken)","Content-Type": "multipart/form-data"])
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let data):
                    observer.onNext(data)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
