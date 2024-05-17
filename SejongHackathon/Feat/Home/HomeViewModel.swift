//
//  HomeViewModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class HomeViewModel {
    private let disposeBag = DisposeBag()
    private var homeNetwork : HomeNetwork
    //모두 완료
    let completeTrigger = PublishSubject<Void>()
    let completeResult : PublishSubject<HomeResponseModel> = PublishSubject()
    
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        homeNetwork = provider.homeNetwork()
        
        completeTrigger.flatMapLatest { _ in
            return self.homeNetwork.homeNetwork(path: completeURL)
        }
        .bind(to: completeResult)
        .disposed(by: disposeBag)
    }
}
