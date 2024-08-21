//
//  AppError.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 3/13/24.
//

import Foundation

/// Error 처리 유형을 정의하는 enum입니다.
public enum ErrorHandlingType {
    /// 무시하는 Error -> print
    case ignore
    /// Error Alert만 표시하는 Error -> alert창 표시
    case showAlert
    /// 재시도 Error -> priint만
//    case retry
    /// Error Alert와 함계 화면 변경 Error -> alert 창 확인 누르면 화면 변경
//    case showAlertAndNavigate
}

/// App에서 발생하는 Error 유형을 정의하는 enum입니다.
public enum AppError {
    /// 임시 네트워크 이슈
    case temporaryNetworkIssue(localizedDescription: String?)
    /// 네트워크 에러
    case networkError(localizedDescription: String?)
    /// Refresh 토큰 만료 에러
    case refreshTokenExpired(localizedDescription: String?)
    /// 커스텀 에러
    case customError(title: String, message: String, localizedDescription: String?)
}

/// Error Alert에 작성되는 내용을 정의하는 struct입니다.
public struct ErrorAlertContent {
    /// Alert창 제목
    var title: String
    /// Alert창 내용 메세지
    var message: String
}

public extension AppError {
    /// 에러 발생 원인
    var localizedDescription: String {
        switch self {
        case .temporaryNetworkIssue(let description),
                .networkError(let description),
                .refreshTokenExpired(let description),
                .customError(_, _, let description):
            return description ?? "에러 발생"
        }
    }
    
    /// 에러 Alert 창 표시 내용
    var content: ErrorAlertContent {
        switch self {
            
        case .temporaryNetworkIssue:
            return .init(title: "네트워크 에러", message: "네트워크 에러 발생 - 재시도 합니다.")
        case .networkError:
            return .init(title: "네트워크 에러", message: "일시적인 네트워크 오류가 발생했습니다.\n잠시 후 다시 시도해주세요.")
        case .refreshTokenExpired:
            return .init(title: "로그인 만료", message: "로그인이 만료되었습니다.\n다시 로그인해주세요.")
        case let .customError(title, message, _):
            return .init(title: title, message: message)
        }
    }
}
