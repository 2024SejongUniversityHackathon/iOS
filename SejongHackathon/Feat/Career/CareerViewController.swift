//
//  CareerViewController.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import RxRelay
import UIKit

final class CareerViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let careerViewModel = CareerViewModel()
    //MARK: - UI Components
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.backgroundColor = .clear
        view.color = .gray
        view.style = .large
        view.clipsToBounds = true
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setBinding()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
}
//MARK: - UI Layout
private extension CareerViewController {
    private func setLayout() {
        self.view.clipsToBounds = true
        self.view.backgroundColor = .white
        self.view.addSubview(loadingIndicator)
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
        loadingIndicator.startAnimating()
    }
}
//MARK: - Binding
private extension CareerViewController {
    private func setBinding() {
        careerViewModel.careerTrigger.onNext(())
        careerViewModel.careerResult.bind(onNext: { [weak self] result in
            guard let self = self else { return }
            if !result.isEmpty {
                self.loadingIndicator.stopAnimating()
            }
        })
        .disposed(by: disposeBag)
    }
}
