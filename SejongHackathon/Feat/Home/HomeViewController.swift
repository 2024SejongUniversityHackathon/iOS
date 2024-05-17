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
    private let naviLogo : UILabel = {
        let label = UILabel()
        label.text = "WADUDU"
        label.textColor = .pointColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    private let advLogo : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "main5")
        view.contentMode = .scaleAspectFill
        return view
    }()
    //성격검사
    private lazy var testBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .white
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "main1"), for: .normal)
        btn.setImage(UIImage(named: "main1"), for: .highlighted)
        btn.addTarget(self, action: #selector(testBtnTapped), for: .touchUpInside)
        return btn
    }()
    //자소서 등록
    private lazy var registerBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .white
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "main3"), for: .normal)
        btn.setImage(UIImage(named: "main3"), for: .highlighted)
        btn.addTarget(self, action: #selector(registerBtnTapped), for: .touchUpInside)
        return btn
    }()
    //성격 유형
    private lazy var categoryBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .white
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "main2"), for: .normal)
        btn.setImage(UIImage(named: "main2"), for: .highlighted)
        btn.addTarget(self, action: #selector(categoryBtnTapped), for: .touchUpInside)
        return btn
    }()
    //결과 도출
    private lazy var resultBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.backgroundColor = .BtnColor
        btn.imageView?.contentMode = .scaleAspectFit
        btn.setImage(UIImage(named: "main4"), for: .normal)
        btn.setImage(UIImage(named: "main4"), for: .highlighted)
        btn.addTarget(self, action: #selector(resultBtnTapped), for: .touchUpInside)
        return btn
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .pointColor
        self.tabBarController?.tabBar.isHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        setLayout()
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
//MARK: - UI Layout
private extension HomeViewController {
    private func setNavigation() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: naviLogo)
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.BackgroundColor]
    }
    private func setLayout() {
        self.title = "메인페이지"
        self.view.backgroundColor = .white
        
        let View = UIView()
        View.backgroundColor = .BackgroundColor
        View.addSubview(advLogo)
        View.addSubview(testBtn)
        View.addSubview(registerBtn)
        View.addSubview(categoryBtn)
        View.addSubview(resultBtn)
        self.view.addSubview(View)
        
        View.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        advLogo.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().inset(self.view.frame.height / 8)
            make.height.equalTo(40)
        }
        testBtn.snp.makeConstraints { make in
            make.top.equalTo(advLogo.snp.bottom).offset(30)
            make.height.equalToSuperview().dividedBy(3.5)
            make.width.equalToSuperview().dividedBy(2.3)
            make.leading.equalToSuperview().inset(20)
        }
        registerBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(4.5)
            make.top.equalTo(testBtn.snp.bottom).offset(10)
        }
        categoryBtn.snp.makeConstraints { make in
            make.top.equalTo(advLogo.snp.bottom).offset(30)
            make.height.equalToSuperview().dividedBy(3.5)
            make.width.equalToSuperview().dividedBy(2.3)
            make.leading.equalTo(testBtn.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        resultBtn.snp.makeConstraints { make in
            make.top.equalTo(registerBtn.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(self.view.frame.height / 9)
        }
    }
}
//MARK: - Target
private extension HomeViewController {
    @objc func testBtnTapped() {
        self.navigationController?.pushViewController(OnboardingStart(), animated: true)
    }
    @objc func categoryBtnTapped() {
        self.navigationController?.pushViewController(CategoryViewController(), animated: true)
    }
    @objc func registerBtnTapped() {
        self.navigationController?.pushViewController(DocumentViewController(), animated: true)
    }
    @objc func resultBtnTapped() {
        self.navigationController?.pushViewController(ResultViewController(), animated: true)
    }
}
