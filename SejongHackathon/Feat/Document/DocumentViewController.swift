//
//  ViewController.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import UIKit
import SnapKit
import RxAlamofire
import RxCocoa
import PDFKit
import RxSwift
import UniformTypeIdentifiers

final class DocumentViewController: UIViewController, UIDocumentPickerDelegate {
    private let disposeBag = DisposeBag()
    private let documentViewModel = DocumentViewModel()
    //MARK: - UI Components
    private let documentImage : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "pdfImage")
        view.contentMode = .scaleAspectFit
        view.backgroundColor = .white
        view.clipsToBounds = true
        return view
    }()
    private let documentLabel : UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.backgroundColor = .white
        label.text = nil
        return label
    }()
    //파일 업로드
    private let uploadBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        return btn
    }()
    private let serverBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("저장하기", for: .normal)
        btn.backgroundColor = .pointColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .heavy)
        return btn
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setLayout()
        setBinding()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
//MARK: - UI Layout
private extension DocumentViewController {
    private func setLayout() {
        self.view.addSubview(documentImage)
        self.view.addSubview(uploadBtn)
        self.view.addSubview(serverBtn)
        self.view.addSubview(documentLabel)
        
        documentImage.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
        }
        uploadBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalToSuperview().dividedBy(3)
            make.center.equalToSuperview()
        }
        serverBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(self.view.frame.height / 9)
            make.height.equalTo(50)
        }
        documentLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(serverBtn.snp.top).inset(-20)
            make.height.equalTo(20)
        }
    }
}
//MARK: - UI Binding
extension DocumentViewController {
    private func setBinding() {
        uploadBtn.rx.tap.bind { [weak self] in
            guard let self = self else { return }
            self.uploadButtonTapped()
        }.disposed(by: disposeBag)
    }
    func uploadButtonTapped() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let url = urls.first {
            self.documentLabel.text = "\(url)"
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // 파일 선택이 취소된 경우 처리
        print("Document picker was cancelled")
    }
}
