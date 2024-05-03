//
//  SplashView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false   // 다음 화면 활성화
    @AppStorage("onboardingDone") var onboardingDone: Bool = false  // 온보딩 완료 여부
    @AppStorage("isLogin") var isLogin: Bool = false                // 로그인 여부
    @AppStorage("newUser") var newUser: Bool = true                 // 약관동의 완료 여부
    
    var socialLogin: String?
    
    var body: some View {
        ZStack {
            
            if !onboardingDone && isActive {
                OnboardingView()    // 온보딩 화면
            } else if onboardingDone && isActive && !isLogin {
                LoginView()         // 로그인 화면
            } else if onboardingDone && isActive && isLogin && !newUser {
                NamoHome()          // 나모 홈 화면
            } else if onboardingDone && isActive && isLogin && newUser {
                AgreeMainView()     // 약관동의 화면
            } else {
                ZStack {            // 스플래시 화면
                    
                    LinearGradient(gradient: Gradient(colors: [Color(hex: 0xe59744), Color.mainOrange]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    
                    Image(.logo)
                }
            }
        }
        .onAppear {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isActive = true
            }
            
            UserDefaults.standard.set(socialLogin, forKey: "socialLogin")
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView(socialLogin: "kakao")
}
