//
//  HomeNetwork.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeNetwork {
    private let network : Network<HomeResponseModel>
    init(network: Network<HomeResponseModel>) {
        self.network = network
    }
    public func homeNetwork(path : String) -> Observable<HomeResponseModel>{
        return network.getNetwork(path: path)
    }
}
