//
//  LoginBtn.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/9/24.
//

import SwiftUI

struct LoginBtn: View {
    
    @State var textContent: String
    @State var textColor: Color
    @State var btnBackgroundColor: String
    @State var btnImage: String
    
    var body: some View {
        
        Button {

        } label: {
            
            Text(textContent)
                .foregroundStyle(textColor)
                .font(Font.pretendard(.bold, size: 18))
                
        }
        .frame(width: screenWidth-50, height: 55)
        .background(Color(hex: btnBackgroundColor))
        .cornerRadius(15)
        .overlay(
            Image(btnImage)
                .padding(.leading, 17),
            alignment: .leading
        )
    }
}

#Preview {
    LoginBtn(textContent: "카카오 로그인", textColor: .black, btnBackgroundColor: "#FFE812", btnImage: "ic_login_kakao")
}
