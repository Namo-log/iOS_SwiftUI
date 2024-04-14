//
//  AgreeMainView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/20/24.
//

import SwiftUI
import Factory

// 약관 동의 화면

struct AgreeMainView: View {
    
    @State var allAgree: Bool = false
    @State var required1: Bool = false
    @State var required2: Bool = false
//    @State var optional1: Bool = false
//    @State var optional2: Bool = false
    
    @State var isActive: Bool = false
    
    @Injected(\.userInteractor) var userInteractor
 
    var body: some View {
 
        VStack {
            
            HStack(spacing: 0) {
                Text("서비스 이용을 위한 ")
                    .font(Font.pretendard(.regular, size: 18))
                Text("약관 동의")
                    .font(Font.pretendard(.bold, size: 18))
            }
            .padding(.top, 80)
            
            Spacer()
            
            AgreeSubView(required1: $required1, required2: $required2)

            Spacer()
            
            Button {
                
                isActive.toggle()
                
                Task {
                    await userInteractor.registerTermsAgreement()
                }
                
            } label: {
                
                if required1 && required2 {
                    
                    Text("확인")
                        .foregroundStyle(.white)
                        .font(Font.pretendard(.bold, size: 18))
                        .frame(width: screenWidth-50, height: 55)
                        .background(Color.mainOrange)
                        .cornerRadius(15)
                    
                } else {
                    
                    Text("확인")
                        .foregroundStyle(Color(.mainOrange))
                        .font(Font.pretendard(.bold, size: 18))
                        .frame(width: screenWidth-50, height: 55)
                        .background(Color.textBackground)
                        .cornerRadius(15)
                }
            }
            .disabled(!(required1 && required2))
            .padding(.bottom, 25)
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    AgreeMainView()
}
