//
//  CategoryViewController.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/18.
//

import Foundation
import SnapKit
import UIKit

class CategoryViewController : UIViewController {
    private let titleText : UITextView = {
        let view = UITextView()
        view.isUserInteractionEnabled = true
        view.isScrollEnabled = true
        view.textAlignment = .left
        view.isEditable = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        
        let attributedText = NSMutableAttributedString()
        
        let largeFont = UIFont.systemFont(ofSize: 24, weight: .bold)
        let largeTextAttributes: [NSAttributedString.Key: Any] = [
            .font: largeFont,
            .foregroundColor: UIColor.black
        ]
        let largeText1 = NSAttributedString(string: "\n\n\n\nR\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText1)
        
        let mediumFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        let mediumTextAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: UIColor.gray
        ]
        let mediumText1 = NSAttributedString(string: "사람들과 함께 공부하거나 일하기보다 혼자 조용하게 공부하고 일하는 것을 더 좋아합니다. 기계 또는 컴퓨터를 다루거나 몸 또는 손을 움직여서 하는 활동하는 것을 좋아합니다. 실용적이고 기능적인 활동을 선호하며, 떠들썩한 분위기보다는 혼자 집중하여 작업하는 것을 편안하게 생각합니다.\n\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText1)
        //2
        let largeText2 = NSAttributedString(string: "I\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText2)
        let mediumText2 = NSAttributedString(string: "깊이 생각하고 탐구하는 활동을 좋아하여, 친구들에 비해 책을 많이 읽거나 학문적인 호기심이 높은 편입니다. 배운 내용을 바탕으로 논리적으로 의견을 주장하거나 글을 쓰는 활동을 선호하며, 특히 과학 분야 관련 서적을 읽거나 과학 분야 또는 융합 학문을 전공하고자 하는 생각을 가지는 경우가 종종 있습니다.\n\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText2)
        //3
        let largeText3 = NSAttributedString(string: "A\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText3)
        let mediumText3 = NSAttributedString(string: "새롭고 창의적인 활동을 좋아하며, 자신이 잘 할 수 있는 표현 방법(글쓰기, 미술, 음악, 공연 등)을 통해 자신의 생각과 느낌을 표현하는 것을 선호합니다. 단순하게 반복되는 활동보다는 창조적인 활동을 좋아하며, 예술 관련 분야를 전공하고 싶어하거나 취미 활동으로 하고 싶은 생각을 가지고 있습니다. \n\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText3)
        //4
        let largeText4 = NSAttributedString(string: "S\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText4)
        let mediumText4 = NSAttributedString(string: "사람들과 함께 어울려 지내는 것을 좋아하며, 협조적이며 도와주고 위로해주는 역할을 잘 해내는 편입니다. 다른 사람들을 가르치거나 안내하고 도와주는 일을 선호하며, 친구들 사이에서 상담 역할을 맡는 경우가 종종 있습니다. \n\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText4)
        //5
        let largeText5 = NSAttributedString(string: "E\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText5)
        let mediumText5 = NSAttributedString(string: "사람들 앞에 나서서 활동하고 인정받는 것을 좋아하며, 리더십을 발휘하거나 발표, 토론 활동을 선호합니다. 앞장서서 활동하는 편이어서 쉽게 친구들과 어울리는 편이며, 목표 달성을 위해 팀 구성원들을 독려하여 이끌어나가는 역할을 해내는 편입니다. \n\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText5)
        //6
        let largeText6 = NSAttributedString(string: "C\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText6)
        let mediumText6 = NSAttributedString(string: "꼼꼼하고 정확하며 책임감이 강한 편으로 지켜야 할 규칙과 규정을 잘 지키며, 계획을 세워 순서대로 공부하거나 일하는 것을 선호합니다. 자료들을 체계적으로 정리하는 것을 좋아하며 기록하는 것을 잘 하는 편이어서 회계, 총무 와 같은 일들을 잘 해내는 경우가 많습니다.  \n\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText6)
        
        view.attributedText = attributedText
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(titleText)
        
        titleText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview()
            make.bottom.equalToSuperview().inset(self.view.frame.height / 11)
            make.top.equalToSuperview().inset(100)
        }
    }
}
