//
//  ResultViewModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class ResultViewModel {
    private let disposeBag = DisposeBag()
    private var resultNetwork : ResultNetwork
    
    let resultTrigger = PublishSubject<Void>()
    let result : PublishSubject<ResultResponseModel> = PublishSubject()
    
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        resultNetwork = provider.resultNetwork()
        
        resultTrigger.flatMapLatest { _ in
            return self.resultNetwork.getResult(path: getScoreURL)
        }
        .bind(to: result)
        .disposed(by: disposeBag)
    }
    
}
