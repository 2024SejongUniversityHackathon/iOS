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
    
    //모두 완료
    let completeTrigger = PublishSubject<Void>()
    let completeResult : PublishSubject<Void> = PublishSubject()
    
    init() {
        
    }
}
