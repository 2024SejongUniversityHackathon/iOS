//
//  ResultNetwork.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import RxSwift
final class ResultNetwork {
    private let network : Network<ResultResponseModel>
    init(network: Network<ResultResponseModel>) {
        self.network = network
    }
    public func getResult(path : String) -> Observable<ResultResponseModel> {
        return network.getNetwork(path: getScoreURL)
    }
}
