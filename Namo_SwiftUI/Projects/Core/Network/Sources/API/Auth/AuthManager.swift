//
//  AuthManager.swift
//  CoreNetwork
//
//  Created by 박민서 on 10/4/24.
//

import Foundation
import SharedUtil

public struct AuthManager {
    
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
        UserDefaults.standard.set(oAuthType.rawValue, forKey: "socialLogin")
    }
    
//    /// 카카오/네이버/애플 로그아웃 상태 저장
//    func setLogoutState(with oAuthType: OAuthType) async {
//        
//        do {
//            // refreshToken 가져오기
//            let refreshToken: String = try KeyChainManager.readItem(key: "refreshToken")
//            // 나모 로그아웃 API 호출
//            try await postNamoLogout(refreshToken: refreshToken)
//            // 로그인 상태 가져오기
//            if let loginState = getLoginState() {
//                switch loginState {
//                    
//                }
//            }
//        } catch {
//            // 에러 처리
//        }
//        
//        
//        // "socialLogin" nil 처리
//        UserDefaults.standard.removeObject(forKey: "socialLogin")
//        
//        
//    }
//    
//    /// 나모 로그아웃 API 호출
//    private func postNamoLogout(refreshToken: String) async throws {
//        let result: BaseResponse<SignInResponseDTO>? = await APIManager.shared.performRequest(endPoint: AuthEndPoint.logout(refreshToken: LogoutRequestDTO(refreshToken: refreshToken)))
//        
//        // 나모 로그아웃 요청이 실패한 경우 에러 throw
//        if result?.code != 200 {
//            throw APIError.customError("로그아웃 실패: 응답 코드 \(result?.code ?? 0)")
//        }
//    }
//    
//    /// OAuthType별 로그아웃 처리
//    private func logout(with oAuthType: OAuthType) {
//        switch oAuthType {
//            
//        case .kakao:
//            <#code#>
//        case .naver:
//            <#code#>
//        case .apple:
//            <#code#>
//        }
//    }
    
    // 카카오/네이버/애플 로그아웃 상태 저장
//    let refreshToken: String = KeyChainManager.readItem(key: "refreshToken")!
    // socialLogin 지워야함
    // 플랫폼 별로 로그아웃 방법이 다르다
    
    // 카카오/네이버/애플 회원탈퇴 상태 저장
    
    
    
    // 카카오/네이버/애플 토큰 키체인에 저장
    // 필요한지는 모르겠음
//    KeyChainManager.addItem(key: "kakaoAccessToken", value: kakaoAccessToken)
//    KeyChainManager.addItem(key: "kakaoRefreshToken", value: kakaoRefreshToken)
    
    
    
    
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
