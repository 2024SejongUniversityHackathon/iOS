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
    private var documentNetwork : DocumentNetwork
    
    //파일 업로드
    let documentTrigger = PublishSubject<DocumentRequestModel>()
    let documentResult : PublishSubject<DocumentResponseModel> = PublishSubject()
    
    init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        documentNetwork = provider.documentNetwork()
        
        documentTrigger.flatMapLatest { data in
            return self.documentNetwork.postAnswer(data: data.data, fileName: data.fileName)
        }
        .bind(to: documentResult)
        .disposed(by: disposeBag)
    }
}
