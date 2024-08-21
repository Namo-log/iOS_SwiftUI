//
//  OnboardingViewModel.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/2/24.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    
    struct State {
    
        // 현재 온보딩 페이지 인덱스
        var onboardingIndex = 1
        // 로그인 화면으로 이동
        var goToLogin = false
    }
    
    @Published var state: State
    
    init(state: State = .init()) { self.state = state }
    
    enum Action {
        
        // 다음으로 버튼 탭할 때
        case onTapNextBtn
    }
    
    func action(_ action: Action) {
        
        switch action {
            
        case .onTapNextBtn:
            onTapNextBtn()
        }
    }
    
    func onTapNextBtn() {
        
        if state.onboardingIndex == 5 {
            UserDefaults.standard.set(true, forKey: "onboardingDone")
            
            state.goToLogin = true
        } else {
            state.onboardingIndex += 1
        }
    }
}
