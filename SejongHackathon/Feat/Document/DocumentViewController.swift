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

class DocumentViewController: UIViewController, UIDocumentPickerDelegate {
    private let disposeBag = DisposeBag()
    private let documentViewModel = DocumentViewModel()
    //MARK: - UI Components
    private let documentView : PDFView = {
        let view = PDFView()
        view.clipsToBounds = true
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }()
    //파일 업로드
    private let uploadBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("PDF 업로드", for: .normal)
        btn.configuration = .bordered()
        return btn
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
        self.view.addSubview(documentView)
        self.view.addSubview(uploadBtn)
        
        documentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        uploadBtn.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalToSuperview().inset(self.view.frame.height / 8)
            make.height.equalTo(40)
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
            print("선택된 파일 : \(url)")
            documentViewModel.documentTrigger.onNext(url)
            
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        // 파일 선택이 취소된 경우 처리
        print("Document picker was cancelled")
    }
}
