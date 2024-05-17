//
//  OnboardingViewModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import RxSwift
import RxCocoa

final class OnboardingViewModel {
    private let disposeBag = DisposeBag()
    private var scoreNetwork : ScoreNetwork
    
    //스코어
    let scoreTrigger = PublishSubject<[Int]>()
    let scoreResult : PublishSubject<ScoreResponseModel> = PublishSubject()
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        scoreNetwork = provider.scoreNetwork()
        
        scoreTrigger.flatMapLatest { score in
            let params : [String:Any] = [
                "r" : score[0],
                "i" : score[1],
                "a" : score[2],
                "s" : score[3],
                "e" : score[4],
                "c" : score[5]
            ]
            return self.scoreNetwork.postScore(path: scoreURL, params: params)
        }
        .bind(to: scoreResult)
        .disposed(by: disposeBag)
    }
}

