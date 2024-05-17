//
//  DocumentNetwork.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import RxSwift
import RxCocoa

final class DocumentNetwork {
    private let network : Network<DocumentResponseModel>
    init(network: Network<DocumentResponseModel>) {
        self.network = network
    }
    public func postAnswer(data: Data, fileName : String) -> Observable<DocumentResponseModel>{
        return network.formDataNetwork(path: documentURL, data: data, fileName: fileName)
    }
}
