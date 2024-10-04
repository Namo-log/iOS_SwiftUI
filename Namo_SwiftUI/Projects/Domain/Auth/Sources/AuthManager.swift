//
//  AuthManager.swift
//  CoreNetwork
//
//  Created by 박민서 on 10/4/24.
//

import Foundation
import SharedUtil
import Core
import ComposableArchitecture

/// 소셜 로그인 및 로그아웃 상태를 관리하는 클래스입니다.
/// - 의존성:
///   - `authClient`를 사용하여 로그아웃 및 로그인 API 요청을 처리합니다.
public struct AuthManager {
    
    @Dependency(\.authClient) var authClient
    
    /// 현재 소셜 로그인 상태
    enum OAuthType: String {
        case kakao
        case naver
        case apple
    }
    
    /// 로그인 상태 가져오기
    func getLoginState() -> OAuthType? {
        guard let oAuthTypeString = UserDefaults.standard.string(forKey: "socialLogin") else { return nil }
        return OAuthType(rawValue: oAuthTypeString)
    }
    
    /// 카카오/네이버/애플 로그인 상태 저장
    func setLoginState(_ oAuthType: OAuthType) {
        // TODO: 로그인 상태 관련 UI 처리 작업 필요한 지 확인
        UserDefaults.standard.set(oAuthType.rawValue, forKey: "socialLogin")
    }
    
    /// 카카오/네이버/애플 로그아웃 상태 저장
    func setLogoutState(with oAuthType: OAuthType) async {
        // TODO: 로그인 상태 관련 UI 처리 작업 필요한 지 확인
        do {
            // 1. get refreshToken
            let refreshToken: String = try KeyChainManager.readItem(key: "refreshToken")
            
            // 2. 나모 로그아웃 API 호출
            try await authClient.reqSignOut(LogoutRequestDTO(refreshToken: refreshToken))
            
            // 3. 소셜 로그인 타입별 로그아웃 진행
            try await logout(with: oAuthType)
            
            // 4. "socialLogin" 세팅 nil 처리
            UserDefaults.standard.removeObject(forKey: "socialLogin")
        } catch {
            // 에러 처리
            print("임시 처리: \(error.localizedDescription)")
        }
    }
    
    /// OAuthType별 로그아웃 처리
    private func logout(with oAuthType: OAuthType) async throws {
        switch oAuthType {
            
        case .kakao:
            try await authClient.kakaoLogout()
        case .naver:
            await authClient.naverLogout()
        case .apple:
            return
        }
    }
    
    // + UI 화면 변경 어디까지 쓸 진 모름
    // 로그인 했을 때
//    DispatchQueue.main.async {
//        UserDefaults.standard.set(true, forKey: "isLogin")
//        UserDefaults.standard.set(namoServerTokens?.newUser, forKey: "newUser")
//        AppState.shared.isTabbarOpaque = false
//        AppState.shared.isTabbarHidden = false
//    }
    
    // 로그아웃 시
//    DispatchQueue.main.async {
//        // 로그인 화면으로 이동
//        UserDefaults.standard.set(false, forKey: "isLogin")
//        AppState.shared.isTabbarHidden = true
//        AppState.shared.currentTab = .home
//    }
}
