//
//  Onboarding1.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

final class Onboarding1 : UIViewController {
    private let disposeBag = DisposeBag()
    
    //MARK: - UI Components
    private let progressView : UIProgressView = {
        let view = UIProgressView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    //질문
    private let questionScroll : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        return view
    }()
    private let questionStack : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        return view
    }()
    //답변
    private let answerStack : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        return view
    }()
    //버튼
    private let nextBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("다음", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .systemBlue
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
private extension Onboarding1 {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.addSubview(progressView)
        self.view.addSubview(nextBtn)
        
        self.addQuestion()
        let scrollView = UIScrollView()
        scrollView.addSubview(questionStack)
        self.view.addSubview(scrollView)
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(self.view.frame.height / 9)
            make.height.equalTo(20)
        }
        nextBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(30)
        }
        scrollView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(0)
            make.top.equalTo(progressView.snp.bottom).offset(30)
            make.bottom.equalTo(nextBtn.snp.top).offset(-30)
        }
        questionStack.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.bottom.equalTo(scrollView)
            make.width.equalTo(scrollView)
        }
    }

    private func addQuestion() {
        let answers = ["매우 싫음", "싫음", "보통", "좋음", "매우 좋음"]
        for index in 0..<4 {
            let view = UIView()
            view.backgroundColor = .white
            
            let text = UILabel()
            text.text = QuestionFile[index]
            text.numberOfLines = 0
            view.addSubview(text)
            
            let answerStack = UIStackView()
            answerStack.axis = .horizontal
            answerStack.distribution = .fillEqually
            answerStack.spacing = 10
            // 정답 버튼 추가
            for answer in answers {
                let btn = UIButton()
                btn.setTitle(answer, for: .normal)
                btn.layer.cornerRadius = 15
                btn.layer.masksToBounds = true
                btn.setTitleColor(.black, for: .normal)
                btn.backgroundColor = .lightGray
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
                answerStack.addArrangedSubview(btn)
            }
            
            view.addSubview(answerStack)
            questionStack.addArrangedSubview(view)
            
            view.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
            }
            
            text.snp.makeConstraints { make in
                make.leading.trailing.top.equalToSuperview().inset(30)
                make.height.greaterThanOrEqualTo(40)
            }
            
            answerStack.snp.makeConstraints { make in
                make.top.equalTo(text.snp.bottom).offset(10)
                make.bottom.equalToSuperview().inset(10)
                make.leading.trailing.equalToSuperview().inset(30)
                make.height.equalTo(40)
            }
        }
    }
}
//MARK: - Binding
private extension Onboarding1 {
    private func setBinding() {
        nextBtn.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.navigationController?.pushViewController(Onboarding2(), animated: true)
        }.disposed(by: disposeBag)
    }
}
