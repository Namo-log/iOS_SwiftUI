//
//  LoginView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/21/24.
//

import SwiftUI
import Factory
import _AuthenticationServices_SwiftUI

struct LoginView: View {
    
    @Injected(\.authInteractor) var authInteractor
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            VStack {
                
                HStack(spacing: 0) {
                    
                    Text("나의 모임 기록 ")
                        .font(Font.pretendard(.regular, size: 18))
                    Text("나모")
                        .font(Font.pretendard(.bold, size: 18))
                }
                .padding(.bottom, 30)
                
                Image(.appLogoSquare2)
            }
            
            Spacer()
            
            VStack(spacing: 0) {
                LoginBtn(textContent: "카카오 로그인", textColor: .black, btnBackgroundColor: 0xFFE812, btnImage: "ic_login_kakao") {
                    
                    Task {
                        
                        await authInteractor.kakaoLogin()
                    }
                }
                
                LoginBtn(textContent: "네이버 로그인", textColor: .white, btnBackgroundColor: 0x03C75A, btnImage: "ic_login_naver 1") {
                    authInteractor.naverLogin()
                }
                .padding(.top, 22)
                
                
                LoginBtn(textContent: "Apple 로그인", textColor: .white, btnBackgroundColor: 0x000000, btnImage: "ic_login_apple"){
                    
                    authInteractor.appleLogin()  
                }
                .padding(.top, 22)
            }
            .padding(.bottom, 50)
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    LoginView()
        .environmentObject(AppState())
}

