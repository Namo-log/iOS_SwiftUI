//
//  SplashView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false   // 다음 화면 활성화
    @State var onboardingDone: Bool = false     // 첫 실행 여부. false면 첫 실행. UserDefaults에 저장
    @State var existToken: Bool = KeyChainManager.itemExists(key: "accessToken")    // 토큰 존재 여부 확인
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        ZStack {
            
            if !onboardingDone && isActive {        // 온보딩 화면을 완료하지 않은 경우
                OnboardingView()
            } else if onboardingDone && isActive && existToken {    // 온보딩 화면을 완료하고 토큰이 존재하는 경우
                
                NamoHome()
                .onAppear {
                    DispatchQueue.main.async {
                        appState.isLogin = true
                    }
                }
                
            } else if onboardingDone && isActive && !existToken {   // 온보딩 화면을 완료하고 토큰이 존재하지 않는 경우
                LoginView()
            } else {
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0xe59744), Color.mainOrange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Image(.logo)
                }
            }
        }
        .onAppear {
            
            self.onboardingDone = UserDefaults.standard.bool(forKey: "onboardingDone")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
