//
//  Onboarding3.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import RxSwift
import RxCocoa
import SnapKit
import UIKit

final class Onboarding3 : UIViewController {
    private let disposeBag = DisposeBag()
    private let onboardingViewModel = OnboardingViewModel()
    private var calculatedAnswer : [Int] = []
    var answerQueue : [OnboardingRequestModel]
    init(answerQueue: [OnboardingRequestModel]) {
        self.answerQueue = answerQueue
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI Components
    private let progressView : UIProgressView = {
        let view = UIProgressView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.progress = Float(CGFloat(0.9))
        view.tintColor = .pointColor
        return view
    }()
    //질문
    private let questionScroll : UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .white
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.layer.masksToBounds = true
        return view
    }()
    private let questionStack : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        view.layer.masksToBounds = true
        return view
    }()
    //답변
    private let answerStack : UIStackView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.axis = .vertical
        view.spacing = 20
        view.distribution = .fill
        view.layer.masksToBounds = true
        return view
    }()
    //버튼
    private let nextBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("완료", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .pointColor
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return btn
    }()
    private let loadingIndicator : UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .gray
        view.backgroundColor = .clear
        view.clipsToBounds = true
        return view
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
private extension Onboarding3 {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.title = ""
        self.view.addSubview(progressView)
        self.view.addSubview(nextBtn)
        
        self.addQuestion()
        let scrollView = UIScrollView()
        scrollView.addSubview(questionStack)
        self.view.addSubview(scrollView)
        
        self.view.addSubview(loadingIndicator)
        
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
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(50)
        }
    }

    private func addQuestion() {
        let answers = ["1", "2", "3", "4", "5"]
        for index in 8..<13 {
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
                btn.backgroundColor = .shadowColor
                btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
                btn.rx.tap.bind { [weak self] _ in
                    guard let self = self else { return }
                    // 버튼의 색상 변경
                    btn.backgroundColor = .pointColor
                    btn.setTitleColor(.white, for: .normal)
                    btn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
                    // 클릭한 버튼 이외의 다른 버튼 색상 원래대로 변경
                    for subview in answerStack.arrangedSubviews {
                        if let otherButton = subview as? UIButton, otherButton != btn {
                            otherButton.backgroundColor = .shadowColor
                            otherButton.setTitleColor(.black, for: .normal)
                            otherButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .light)
                        }
                    }
                    // 버튼의 타이틀 가져오기
                    guard let buttonText = btn.titleLabel?.text else { return }
                    
                    // 해당 버튼의 인덱스에 해당하는 텍스트
                    let text = QuestionFile[index]
                    
                    //서버로 전송
                    answerQueue.append(OnboardingRequestModel(question: text, answer: buttonText))
                }.disposed(by: disposeBag)
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
private extension Onboarding3 {
    private func setBinding() {
        nextBtn.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            if answerQueue.count == 13 {
                //서버 저장
                calculate()
                onboardingViewModel.scoreTrigger.onNext(calculatedAnswer)
                print("\(calculatedAnswer)")
                loadingIndicator.startAnimating()
                onboardingViewModel.scoreResult.bind { data in
                    if data.header?.responseCode == 200 {
                        self.loadingIndicator.stopAnimating()
                        self.navigationController?.pushViewController(TabBarViewController(), animated: true)
                    }
                }.disposed(by: disposeBag)
            }else{
                showMessage("누락된 질문이 있습니다.")
            }
        }.disposed(by: disposeBag)
    }
    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    private func calculate() {
        let answerIndex = [3,2,2,2,2,2]
        var flag = 0
        var result = 0
        let answer = answerQueue.compactMap { $0.answer }
        for a in answerIndex {
            result = 0
            for index in flag...(flag+a-1) {
                result += Int(answer[index]) ?? 0
            }
            calculatedAnswer.append(result)
            flag += a
        }
    }
}
