//
//  AgreeViewModel.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/2/24.
//

import Foundation

class AgreeViewModel: ObservableObject {
    
    private let termUseCase: TermUseCase
    
    struct State {
        
        // 첫 번째  동의 여부
        var required1: Bool = false
        // 두 번째 동의 여부
        var required2: Bool = false
        
        var goToNext: Bool = false
    }
    
    @Published var state: State
    
    // 매개변수 기본값
    // .init()은 State()랑 같은 의미
    init(
        termUseCase: TermUseCase = .init(),
        state: State = .init()
    ) {
        self.termUseCase = termUseCase
        self.state = state
    }
    
    enum Action {
        case onTapAllAgreementBtn
        case onTapAgreeBtn
    }
    
    func action(_ action: Action) {
        
        switch action {
            
        // 전체 동의 버튼 탭
        case .onTapAllAgreementBtn:
            agreeAll()
        // 약관동의 확인
        case .onTapAgreeBtn:
            Task {
                await registerTermAgreement()
            }
        }
    }
    
    // 전체 동의 버튼 탭
    func agreeAll() {
        self.state.required1 = true
        self.state.required2 = true
    }
    
    // 약관동의 확인
    func registerTermAgreement() async {
        
        await termUseCase.registerTermsAgreement()
    }
}
