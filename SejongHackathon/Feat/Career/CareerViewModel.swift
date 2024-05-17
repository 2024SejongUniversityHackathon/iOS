//
//  CareerViewModel.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

final class CareerViewModel {
    private let disposeBag = DisposeBag()
    //네트워크
    private var careerNetwork : CareerNetwork
    private var careerServerNetwork : CareerServerNetwork
    
    //커리어 Open API
    let careerTrigger = PublishSubject<Void>()
    let careerResult : BehaviorRelay<[CareerResponseModel]> = BehaviorRelay(value: [])
    
    //커리어 서버 전송
    let careerServerTrigger = PublishSubject<[CareerServerRequestModel]>()
    
    init() {
        let provider = NetworkProvider(endpoint: OpenApiURL)
        let serverprovider = NetworkProvider(endpoint: endpointURL)
        careerNetwork = provider.careerNetwork()
        careerServerNetwork = provider.careerServerNetwork()
        
        setBinding()
    }
}
//MARK: - Binding
extension CareerViewModel {
    private func setBinding() {
        careerTrigger
            .flatMap { [unowned self] _ in
                Observable.concat(
                    (1...11).map { index in
                        self.careerNetwork.getCareer(path: OpenApiURL, pageIndex: index)
                    }
                ).toArray()
            }
            .map { $0.flatMap { $0 } } 
            .subscribe(onNext: { [weak self] newCareerData in
                self?.careerResult.accept(newCareerData)
            })
            .disposed(by: disposeBag)
        careerResult.subscribe(onNext: {[weak self] openData in
            guard let self = self else { return }
            let jobs = openData.flatMap { $0.jobs ?? [] }
            var serverData: [CareerServerRequestModel] = []
            for job in jobs {
                if let jobName = job.job_nm, let jobWork = job.work {
                    let serverModel = CareerServerRequestModel(name: jobName, text: jobWork)
                    serverData.append(serverModel)
                }
            }
            let result = self.careerServerNetwork.CareerToServer(path: "", data: serverData)
        }).disposed(by: disposeBag)
    }
}
