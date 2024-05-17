//
//  OnboardingStart.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

final class OnboardingStart : UIViewController{
    private let disposeBag = DisposeBag()
    
    //MARK: - UI Components
    private let titleText : UITextView = {
        let view = UITextView()
        view.isUserInteractionEnabled = false
        view.isScrollEnabled = false
        view.textAlignment = .left
        view.isEditable = false
        let attributedText = NSMutableAttributedString()
        
        let largeFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let largeTextAttributes: [NSAttributedString.Key: Any] = [
            .font: largeFont,
            .foregroundColor: UIColor.black
        ]
        let largeText = NSAttributedString(string: "큰 텍스트\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText)
        
        let mediumFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        let mediumTextAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: UIColor.darkGray
        ]
        let mediumText = NSAttributedString(string: "중간 크기 텍스트\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText)
        
        view.attributedText = attributedText
        return view
    }()
    //버튼
    private let nextBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .pointColor
        return btn
    }()
    
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
private extension OnboardingStart {
    private func setLayout() {
        self.title = ""
        self.view.backgroundColor = .white
        self.view.addSubview(titleText)
        self.view.addSubview(nextBtn)
        
        titleText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.center.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
        }
        nextBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(30)
        }
    }
}
//MARK: - Binding
private extension OnboardingStart {
    private func setBinding() {
        nextBtn.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.pushViewController(Onboarding1(), animated: true)
        }.disposed(by: disposeBag)
    }
}
