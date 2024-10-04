//
//  AuthManager.swift
//  CoreNetwork
//
//  Created by 박민서 on 10/4/24.
//

import Foundation

public struct AuthManager {
    // UserDefaults
    // 카카오/네이버/애플 로그인 상태 저장
//    UserDefaults.standard.set("kakao", forKey: "socialLogin")
//    UserDefaults.standard.set("naver", forKey: "socialLogin")
//    UserDefaults.standard.set("apple", forKey: "socialLogin")
    
    
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
