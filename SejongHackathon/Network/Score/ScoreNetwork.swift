//
//  Score.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import RxSwift
import RxCocoa

final class ScoreNetwork {
    private let network : Network<ScoreResponseModel>
    init(network: Network<ScoreResponseModel>) {
        self.network = network
    }
    public func postScore(path : String, params : [String:Any]) -> Observable<ScoreResponseModel> {
        return network.postNetwork(path: scoreURL, params: params)
    }
}
