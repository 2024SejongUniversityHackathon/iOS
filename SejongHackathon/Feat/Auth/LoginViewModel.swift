//
//  LoginViewModel.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import AuthenticationServices
import SwiftKeychainWrapper

final class LoginViewModel : NSObject, ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    private lazy var disposeBag = DisposeBag()
    private lazy var loginViewController = LoginViewController()
    private var loginNetwork : LoginNetwork
    
    //애플 로그인
    let appleLoginTrigger = PublishSubject<Void>()
    
    //서버 로그인
    let serverLoginTrigger = PublishSubject<LoginRequestModel>()
    let serverLoginResult : PublishSubject<LoginResponseModel> = PublishSubject()
    
    override init() {
        let provider = NetworkProvider(endpoint: endpointURL)
        loginNetwork = provider.loginNetwork()
        
        super.init()
        //바인딩
        setBinding()
    }
    private func setBinding() {
        self.appleLoginTrigger.subscribe(onNext: {[weak self] in
            guard let self = self else{return}
            self.handleAppleSignInButtonTapped()
        })
        .disposed(by: disposeBag)
        self.serverLoginTrigger.flatMapLatest { loginModel in
            return self.loginNetwork.getLogin(loginModel)
        }
        .bind(to: serverLoginResult)
        .disposed(by: disposeBag)
        self.serverLoginResult.subscribe(onNext: { result in
            if result.body.data?.accessToken != nil {
                if let accessToken = result.body.data?.accessToken{
                    KeychainWrapper.standard.removeAllKeys()
                    let JWTaccessToken = "Bearer \(accessToken)"
                    KeychainWrapper.standard.set(JWTaccessToken, forKey: "JWTaccessToken")
                }
            }
        })
        .disposed(by: disposeBag)
    }
    private func handleAppleSignInButtonTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            if let code = appleIDCredential.authorizationCode?.base64EncodedString(){
                let name = appleIDCredential.fullName?.givenName ?? "익명"
                let email = appleIDCredential.email ?? "Permission@Denied"
                self.serverLoginTrigger.onNext(LoginRequestModel(username: name, email: email, authorizationCode: code))
            }
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("애플 로그인 오류 \(error)")
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.loginViewController.view.window!
    }
}
