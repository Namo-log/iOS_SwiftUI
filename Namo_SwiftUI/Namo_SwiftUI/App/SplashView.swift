//
//  SplashView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import SwiftUI

struct SplashView: View {
    
    @State var isActive: Bool = false   // 다음 화면 활성화
    @AppStorage("onboardingDone") var onboardingDone: Bool = false
    @AppStorage("isLogin") var isLogin: Bool = false
    
    var socialLogin: String?
    
    var body: some View {
        ZStack {
            
            if !onboardingDone && isActive {
                OnboardingView()
            } else if onboardingDone && isActive && !isLogin {
                LoginView()
            } else if onboardingDone && isActive && isLogin {
                NamoHome()
            } else {
                ZStack {
                    
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
