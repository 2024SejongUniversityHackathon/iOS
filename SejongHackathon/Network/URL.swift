//
//  URL.swift
//  CourseApp
//
//  Created by 정성윤 on 2024/05/17.
//

import Foundation

//MARK: - 서버 엔드포인트
let endpointURL : String = "http://52.78.154.100:8080"

//MARK: - OpenAPI(커리어넷)
let OpenApiURL : String = "https://www.career.go.kr/cnet/front/openapi/jobs.json"

//MARK: - 로그인
let loginURL : String = "/login/oauth2/code/apple"

//MARK: - 문서업로드
let documentURL : String = "/api/documents/uploadPdf"

//MARK: - 완료
let completeURL : String = "/member/check"

//MARK: - 점수
let scoreURL : String = "/scores" //보내기
let getScoreURL : String = "/my-scores" //가져오기
