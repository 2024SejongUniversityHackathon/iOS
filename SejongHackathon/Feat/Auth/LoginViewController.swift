//
//  LoginViewController.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import AuthenticationServices

final class LoginViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private let loginViewModel = LoginViewModel()
    //MARK: UI Components
    private let image : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "loginImage")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    private let appleBtn : ASAuthorizationAppleIDButton = {
        let btn = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        return btn
    }()
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .gray
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = true
        let window = UIWindow(frame: UIScreen.main.bounds)
        let loginVC = LoginViewController()
        window.rootViewController = UINavigationController(rootViewController: loginVC)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setBinding()
    }
}
//MARK: - UI Layout
private extension LoginViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(image)
        self.view.addSubview(appleBtn)
        self.view.addSubview(loadingIndicator)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        appleBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(100)
        }
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
//MARK: - UI Binding
private extension LoginViewController{
    private func setBinding() {
        appleBtn.rx.controlEvent(.touchUpInside)
            .subscribe(onNext: { [weak self] in
                guard let self = self else{return}
                self.loginViewModel.appleLoginTrigger.onNext(())
                self.loadingIndicator.startAnimating()
            })
            .disposed(by: disposeBag)
        loginViewModel.serverLoginResult
            .subscribe(onNext: { [weak self] data in
                guard let self = self else{return}
                if (data.body.data?.accessToken) != nil {
                    self.loadingIndicator.stopAnimating()
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
