//
//  MainViewModel.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa

final class DocumentViewModel {
    private let disposeBag = DisposeBag()
    //네트워크
    
    
    //파일 업로드
    let documentTrigger = PublishSubject<URL>()
    let documentResult : PublishSubject<Void> = PublishSubject()
    
    init() {
        
    }
}
