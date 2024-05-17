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
    
    //MARK: - UI Components
    private let chart : RadarChartView = {
        let view = RadarChartView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = .white
        view.contentMode = .scaleAspectFill
        let xLabels = ["I", "R", "A", "S", "E", "C"]
        view.xAxis.valueFormatter = IndexAxisValueFormatter(values: xLabels)
        view.xAxis.labelFont = UIFont.systemFont(ofSize: 13)
        view.clipsToBounds = true
        return view
    }()
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
        setChart()
    }
    private func setChart() {
        let entries = [
            RadarChartDataEntry(value: 4),
            RadarChartDataEntry(value: 3),
            RadarChartDataEntry(value: 2),
            RadarChartDataEntry(value: 5),
            RadarChartDataEntry(value: 4),
            RadarChartDataEntry(value: 4)
        ]
        let dataSet = RadarChartDataSet(entries: entries, label: "육각형 그래프")
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
        
    }
}
