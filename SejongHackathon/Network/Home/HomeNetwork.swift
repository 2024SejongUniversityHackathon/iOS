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
    private let network : Network<LoginResponseModel>
    init(network: Network<LoginResponseModel>) {
        self.network = network
    }
    
}
