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
    //MARK: - 직업정보
    public func careerNetwork() -> CareerNetwork {
        let network = Network<CareerResponseModel>(endpoint)
        return CareerNetwork(network: network)
    }
    //MARK: - 직업정보 서버통신
    public func careerServerNetwork() -> CareerServerNetwork {
        let network = Network<CareerServerResponseModel>(endpoint)
        return CareerServerNetwork(network: network)
    }
    //MARK: - 문서 업로드
    public func documentNetwork() -> DocumentNetwork {
        let network = Network<DocumentResponseModel>(endpoint)
        return DocumentNetwork(network: network)
    }
    //MARK: - 점수
    public func scoreNetwork() -> ScoreNetwork {
        let network = Network<ScoreResponseModel>(endpoint)
        return ScoreNetwork(network: network)
    }
}
