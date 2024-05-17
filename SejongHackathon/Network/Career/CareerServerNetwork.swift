//
//  CareerServerNetwork.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

final class CareerServerNetwork {
    private let network : Network<CareerServerResponseModel>
    init(network: Network<CareerServerResponseModel>) {
        self.network = network
    }
    
    public func CareerToServer(path: String, data : [CareerServerRequestModel]) -> Observable<CareerServerResponseModel> {
        let fullpath = ""
        let params : [String:Any] = [:]
        return network.postNetwork(path: path, params: params)
    }
}
