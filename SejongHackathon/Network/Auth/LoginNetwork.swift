//
//  LoginNetwork.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//


import Foundation
import RxSwift
import RxCocoa
import Alamofire

final class LoginNetwork {
    private let network : Network<LoginResponseModel>
    init(network: Network<LoginResponseModel>) {
        self.network = network
    }
    public func getLogin(_ loginModel : LoginRequestModel) -> Observable<LoginResponseModel> {
        let params : [String:Any] = [
            "username" : loginModel.username,
            "email" : loginModel.email,
            "authorizationCode" : loginModel.authorizationCode
        ]
        return network.loginNetwork(path: loginURL, params: params)
    }
}
