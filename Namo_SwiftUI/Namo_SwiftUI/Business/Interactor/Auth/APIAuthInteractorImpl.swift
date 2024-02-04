//
//  APIAuthInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation
import Factory

// 예시로 넣어둔 AuthInteractor 구현체이며 실제 구현에 쓰일 예정입니다.
class APIAuthInteractorImpl: AuthInteractor {
    
    // Interactor는 AppState와 Repository를 주입받고 로직에 활용합니다.
    // Interactor의 AppState는 View의 Interactor를 통해 직접 접근할 수는 없고 Interactor의 로직으로 조작합니다.
    @Injected(\.authRepository) private var authRepository
    @Injected(\.appState) private var appState: AppState
    
    func kakaoLogin() {
        do{}
    }
    
    func reissuanceToken() {
        do {}
    }
    
    func logout() {
        do {}
    }
    
    // 예시로 쓰인 메소드입니다.
    func example() {
        appState.example += 1
    }
}
