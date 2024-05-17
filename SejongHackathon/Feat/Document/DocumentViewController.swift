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
    private var selectedFileURL: URL?
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
        label.clipsToBounds = true
        return label
    }()
    //파일 업로드
    private let uploadBtn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .clear
        btn.clipsToBounds = true
        return btn
    }()
    private let serverBtn : UIButton = {
        let btn = UIButton()
        btn.setTitle("저장하기", for: .normal)
        btn.backgroundColor = .pointColor
        btn.layer.cornerRadius = 10
        btn.layer.masksToBounds = true
        btn.clipsToBounds = true
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
        self.view.addSubview(loadingIndicator)
        
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
        loadingIndicator.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.center.equalToSuperview()
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
        documentViewModel.documentResult.bind { data in
            if ((data.header?.responseCode) == 200) {
                self.loadingIndicator.stopAnimating()
                self.showMessage("업로드 성공!")
            }else{
                self.loadingIndicator.stopAnimating()
                self.showMessage("업로드 실패!")
            }
        }.disposed(by: disposeBag)
    }
    func uploadButtonTapped() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.pdf])
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        self.present(documentPicker, animated: true, completion: nil)
    }
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if let selectedFileURL = urls.first {
            self.selectedFileURL = selectedFileURL
            print("Selected file URL: \(selectedFileURL)")
            
            // 선택된 파일이 PDF인지 확인
            if selectedFileURL.pathExtension == "pdf" {
                // 파일 접근 권한 요청
                let isAccessing = selectedFileURL.startAccessingSecurityScopedResource()
                defer { if isAccessing { selectedFileURL.stopAccessingSecurityScopedResource() } }
                
                // 파일명 디코딩
                let fileName = selectedFileURL.deletingPathExtension().lastPathComponent
                if let encodedString = fileName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                   let url = URL(string: encodedString),
                   let decodedString = url.lastPathComponent.removingPercentEncoding {
                    print("Decoded file name: \(decodedString)")
                    self.documentLabel.text = "\(decodedString).pdf"
                    
                    // 파일 데이터 가져오기
                    do {
                        let fileData = try Data(contentsOf: selectedFileURL)
                        // 파일 데이터 활용
                        serverBtn.rx.tap.bind { _ in
                            self.loadingIndicator.startAnimating()
                            self.documentViewModel.documentTrigger.onNext(DocumentRequestModel(data: fileData, fileName: decodedString))
                        }.disposed(by: disposeBag)
                        print("File data loaded successfully.")
                    } catch {
                        self.showMessage("데이터를 가져올 수 없습니다.")
                    }
                }
            } else {
                self.showMessage("PDF 파일만 선택 가능합니다.")
            }
        }
    }
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("Document picker was cancelled")
    }
    
    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
