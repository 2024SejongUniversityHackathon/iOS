//
//  ResultViewController.swift
//  SejongHackathon
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa
import UIKit
import Charts
import DGCharts


final class ResultViewController : UIViewController {
    private let disposeBag = DisposeBag()
    private let resultViewModel = ResultViewModel()
    //MARK: - UI Components
    private let chart : RadarChartView = {
        let view = RadarChartView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        let xLabels = ["R", "I", "A", "S", "E", "C"]
        view.xAxis.valueFormatter = IndexAxisValueFormatter(values: xLabels)
        view.xAxis.labelFont = UIFont.systemFont(ofSize: 13)
        view.clipsToBounds = true
        return view
    }()
    private let titleText : UITextView = {
        let view = UITextView()
        view.isUserInteractionEnabled = false
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
        let largeText = NSAttributedString(string: "문승재씨의 Ai추천 직무는 회계사, 물리학연구원, 블록체인전문가입니다.\n\n", attributes: largeTextAttributes)
        attributedText.append(largeText)
        
        let mediumFont = UIFont.systemFont(ofSize: 18, weight: .medium)
        let mediumTextAttributes: [NSAttributedString.Key: Any] = [
            .font: mediumFont,
            .foregroundColor: UIColor.darkGray
        ]
        let mediumText = NSAttributedString(string: "너의 진로 희망은 블록체인 전문가군! 그렇다면 네 생기부를 블록체인 분야에 관련된 경험과 지식을 강조하여 조정하는 것이 좋겠어. 예를 들어, 학교나 커뮤니티에서 블록체인 기술에 대한 프로젝트나 활동에 참여한 경험을 강조할 수 있어. 또한 블록체인에 대한 관심을 나타내는 활동이나 자격증 취득, 관련 공부를 했다면 그것들도 넣어보는 것도 좋을 거야. 블록체인 분야에서 경험과 지식을 쌓는 것이 네 진로에 도움이 될 거니까, 그런 부분들을 부각시키는 것이 중요할 거야!\n", attributes: mediumTextAttributes)
        attributedText.append(mediumText)
        
        view.attributedText = attributedText
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
private extension ResultViewController {
    private func setLayout() {
        self.view.backgroundColor = .white
        self.view.clipsToBounds = true
        self.view.addSubview(chart)
        self.view.addSubview(titleText)
        
        titleText.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.center.equalToSuperview().offset(60)
            make.bottom.equalToSuperview()
        }
        chart.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(80)
            make.bottom.equalTo(titleText.snp.top).offset(0)
            make.top.equalToSuperview().inset(40)
            make.height.equalToSuperview().dividedBy(2.3)
        }
    }
    private func setChart(_ data : RIASECData) {
        
        let entries = [
            RadarChartDataEntry(value: Double(data.r)),
            RadarChartDataEntry(value: Double(data.i)),
            RadarChartDataEntry(value: Double(data.a)),
            RadarChartDataEntry(value: Double(data.s)),
            RadarChartDataEntry(value: Double(data.e)),
            RadarChartDataEntry(value: Double(data.c))
        ]
        let dataSet = RadarChartDataSet(entries: entries, label: "RIASEC")
        dataSet.colors = [NSUIColor.systemBlue]
        dataSet.fillColor = NSUIColor.systemBlue
        dataSet.drawFilledEnabled = true
        let data = RadarChartData(dataSet: dataSet)
        chart.legend.horizontalAlignment = .right
        chart.data = data
    }
}
//MARK: - Binding
private extension ResultViewController {
    private func setBinding() {
        resultViewModel.resultTrigger.onNext(())
        resultViewModel.result.bind { data in
            DispatchQueue.main.async {
                if let chartData = data.body?.data {
                    self.setChart(chartData)
                }
            }
        }.disposed(by: disposeBag)
    }
}
