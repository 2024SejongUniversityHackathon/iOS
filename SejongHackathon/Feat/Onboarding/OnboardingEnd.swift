//
//  OnboardingEndViewController.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import SnapKit
import UIKit

final class OnboardingEnd : UIViewController {
    //MARK: - UI Components
    private let image : UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.image = UIImage(named: "onboardingEndImageE")
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        return view
    }()
    private lazy var resultBtn : UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.backgroundColor = .pointColor
        btn.setTitle("결과 보기", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        btn.addTarget(self, action: #selector(resultBtnTapped), for: .touchUpInside)
        return btn
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.tintColor = .pointColor
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
//MARK: - UI Layout
private extension OnboardingEnd {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.title = ""
        self.view.addSubview(image)
        self.view.addSubview(resultBtn)
        image.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        resultBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(100)
            make.height.equalTo(50)
            make.bottom.equalToSuperview().inset(self.view.frame.height / 12)
        }
    }
    @objc func resultBtnTapped() {
        self.navigationController?.pushViewController(ResultViewController(), animated: true)
    }
}
