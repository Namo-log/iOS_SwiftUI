//
//  LoginView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/21/24.
//

import SwiftUI

struct LoginView: View {
    
    @StateObject var loginViewModel: LoginViewModel = .init()
    @State var accessToken = ""
    @State var refreshToken = ""
    
    var body: some View {
        
        if loginViewModel.isLogin {
            
            NamoHome()
        } else {
            
            VStack {
                
                Spacer()
                
                HStack(spacing: 0) {
                    Text("나의 모임 기록 ")
                        .font(Font.pretendard(.regular, size: 18))
                        
                    Text("나모")
                        .font(Font.pretendard(.bold, size: 18))
                }
                
                Image(.appLogoSquare2)
                
                Spacer()
                
                Button {
                    
                    loginViewModel.kakaoLogin()
                    
                } label: {
                    
                    HStack {
                        
                        Spacer()
                        
                        Image(.icLoginKakao)
                            .padding(.leading, -105)
                        
                        Text("카카오 로그인")
                            .foregroundStyle(.black)
                            .font(Font.pretendard(.bold, size: 18))
                        
                        Spacer()
                    }
                    .frame(width: screenWidth-50, height: 55)
                    .background(Color(hex: "#FFE812"))
                    .cornerRadius(15)
                }
                
                Button {
                    
                } label: {
                    
                    HStack {
                        
                        Spacer()
                        
                        Image(.icLoginNaver)
                            .padding(.leading, -105)
                        
                        Text("네이버 로그인")
                            .foregroundStyle(.white)
                            .font(Font.pretendard(.bold, size: 18))
                        
                        Spacer()
                    }
                    .frame(width: screenWidth-50, height: 55)
                    .background(Color(hex: "#03C75A"))
                    .cornerRadius(15)
                }
                .padding(.top)
                
                Button {
                    
                } label: {
                    
                    HStack {
                        
                        Spacer()
                        
                        Image(.icLoginApple)
                            .padding(.leading, -105)
                        
                        Text("Apple 로그인")
                            .foregroundStyle(.white)
                            .font(Font.pretendard(.bold, size: 18))
                        
                        Spacer()
                    }
                    .frame(width: screenWidth-50, height: 55)
                    .background(.black)
                    .cornerRadius(15)
                }
                .padding(.top)
                
                Spacer()
            
            }
            
        }
    }
}

#Preview {
    LoginView()
}
