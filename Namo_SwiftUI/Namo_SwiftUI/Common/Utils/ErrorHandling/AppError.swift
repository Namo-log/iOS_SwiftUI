//
//  AppError.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 3/13/24.
//

import Foundation

enum ErrorHandlingType {
    /// 무시하는 Error -> print
    case ignore
    /// Error Alert만 표시하는 Error -> alert창 표시
    case showAlert
    /// 재시도 Error -> priint만
    case retry
    /// Error Alert와 함계 화면 변경 Error -> alert 창 확인 누르면 화면 변경
    case showAlertAndNavigate
}

enum AppError {
    /// 임시 네트워크 이슈
    case temporaryNetworkIssue(localizedDescription: String?)
    /// 네트워크 에러
    case networkError(localizedDescription: String?)
    /// Refresh 토큰 만료 에러
    case refreshTokenExpired(localizedDescription: String?)
    /// 커스텀 에러
    case customError(title: String, message: String, localizedDescription: String?)
}
