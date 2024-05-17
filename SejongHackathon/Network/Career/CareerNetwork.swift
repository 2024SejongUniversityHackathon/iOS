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
    private let network : Network<Void>
    init(network: Network<Void>) {
        self.network = network
    }
    public func getCareer(paht: String) -> Observable<Void> {
        return network.getNetwork(path: path)
    }
}
