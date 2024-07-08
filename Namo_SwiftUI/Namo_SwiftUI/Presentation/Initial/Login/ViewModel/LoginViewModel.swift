//
//  LoginViewModel.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/3/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private let authUseCase: AuthUseCase

    init(
        authUseCase: AuthUseCase = .init()
    ) {
        self.authUseCase = authUseCase
    }
    
    enum Action {
        case loginKakao
        case loginNaver
        case loginApple
    }
    
    func action(_ action: Action) {
        
        switch action {
            
        case .loginKakao:
            Task {
                await kakaoLogin()
            }
        case .loginNaver:
            naverLogin()
        case .loginApple:
            appleLogin()
        }
    }
    
    // 카카오 로그인
    func kakaoLogin() async { await authUseCase.kakaoLogin() }
    // 네이버 로그인
    func naverLogin() { authUseCase.naverLogin() }
    // 애플 로그인
    func appleLogin() { authUseCase.appleLogin()
}
}
