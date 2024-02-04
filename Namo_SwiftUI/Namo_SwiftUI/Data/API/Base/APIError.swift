//
//  APIError.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/29/24.
//

import Foundation

/// 네트워크 요청 시 발생할 수 있는 에러를 정의한 열거형입니다.
enum APIError: Error {
    /// 옳지 않은 URL
    case invalidURL
    /// response가 옳지 않을 때
    case invalidResponse
    /// 400 ~ 499에러
    case badRequest(String?)
    /// 500
    case serverError(String?)
    /// JSON parsing 에러
    case parseError(String?)
    /// 알 수 없는 에러.
    case unknown
    /// 커스텀 정의 에러 케이스
    case customError(String)
}
