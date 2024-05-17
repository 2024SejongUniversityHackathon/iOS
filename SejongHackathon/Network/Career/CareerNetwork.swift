//
//  CareerNetwork.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class CareerNetwork {
    private let network : Network<CareerResponseModel>
    init(network: Network<CareerResponseModel>) {
        self.network = network
    }
    public func getCareer(path: String, pageIndex : Int) -> Observable<[CareerResponseModel]> {
        let fullpath = "\(path)?apiKey=\(APIKEY)&pageIndex=\(pageIndex)"
        return network.OpenApiNetwork(path: fullpath)
    }
}
