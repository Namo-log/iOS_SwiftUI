//
//  LoginBtn.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/9/24.
//

import SwiftUI

import SharedDesignSystem
import SharedUtil

struct LoginBtn: View {
    
    let textContent: String
    let textColor: Color
    let btnBackgroundColor: UInt
    let btnImage: String
    let action: () -> Void
    
    var body: some View {
        
        Button {
            
            action()

        } label: {
            
            ZStack {
                Rectangle()
                    .frame(width: screenWidth-50, height: 55)
                    .foregroundStyle(Color(hex: btnBackgroundColor))
                    .cornerRadius(15)
                
                Text(textContent)
                    .foregroundStyle(textColor)
                    .font(Font.pretendard(.bold, size: 18))
            }
        }
        .overlay(
            Image(btnImage)
                .padding(.leading, 17),
            alignment: .leading
        )
    }
}

#Preview {
    LoginBtn(textContent: "카카오 로그인", textColor: .black, btnBackgroundColor: 0xFFE812, btnImage: "ic_login_kakao", action: {})
}
