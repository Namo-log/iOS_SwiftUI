//
//  SettingViewModel.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/3/24.
//

import Foundation
import SwiftUI

class SettingViewModel: ObservableObject {
    
//    private let authUseCase = AuthUseCase.shared
    
    struct State {
        
        var showLogoutAlert: Bool = false
        var showDeleteAccountAlert: Bool = false
        var isBackBtnDisabled = false
        var navigationBarColor: UIColor = .white
    }
    
    @Published var state: State
    
    init(
        state: State = .init()
    ) {
        self.state = state
    }
    
    enum Action {
        
        // 로그아웃 확인 버튼 탭
        case onTapLogoutBtn
        // 회원탈퇴 확인 버튼 탭
        case onTapDeleteAccountBtn
        // showAlert 활성화 여부
        case onChangeShowAlert(value: Bool)
    }
    
    func action(_ action: Action) {
        
        switch action {
        
        case .onTapLogoutBtn:
            Task {
                await logout()
            }
            
        case .onTapDeleteAccountBtn:
            Task {
                await withdrawMember()
            }
            
        // showAlert 활성화 여부
        case .onChangeShowAlert(let value):
            controlBackBtnDisabled(showAlert: value)
        }
    }
    
    // Alert가 활성화됐을 때 뒤로가기 버튼 비활성화, NavigationBar 색상 변경
    func controlBackBtnDisabled(showAlert: Bool) {
        
        if !showAlert {
            self.state.isBackBtnDisabled = false
            self.state.navigationBarColor = .white
            
        } else {
            
            self.state.isBackBtnDisabled = true
            self.state.navigationBarColor = .gray
        }
    }

    func logout() async {
        
//        await authUseCase.logout()
    }
    
    func withdrawMember() async {
        
//        await authUseCase.withdrawMember()
    }
 }
