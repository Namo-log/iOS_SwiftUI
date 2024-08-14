//
//  AgreeView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/20/24.
//

import SwiftUI
import Factory

// 약관 동의 화면

struct AgreeView: View {
    
    @StateObject var agreeVM: AgreeViewModel = .init()

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
            
             AgreeSubView(agreeVM: agreeVM)

            Spacer()
            
            Button {
                
                agreeVM.state.goToNext.toggle()
                
                // 약관동의 요청
                agreeVM.action(.onTapAgreeBtn)
                
            } label: {
                
                if agreeVM.state.required1 && agreeVM.state.required2 {
                    
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
            .disabled(!(agreeVM.state.required1 && agreeVM.state.required2))
            .padding(.bottom, 25)
        }
        .padding(.vertical, 30)
    }
}

#Preview {
    AgreeView()
}
