//
//  NetworkProvider.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxCocoa
import RxSwift

final class NetworkProvider {
    private let endpoint : String
    init(endpoint: String) {
        self.endpoint = endpoint
    }
    //MARK: - 로그인
    public func loginNetwork() -> LoginNetwork {
        let network = Network<LoginResponseModel>(endpoint)
        return LoginNetwork(network: network)
    }
}