//
//  ViewController.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

final class HomeViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let homeViewModel = HomeViewModel()
    //MARK: - UI Components
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
private extension HomeViewController {
    private func setLayout() {
        self.view.backgroundColor = .shadowColor
        
    }
}
//MARK: - Binding
private extension HomeViewController {
    private func setBinding() {
        
    }
}
