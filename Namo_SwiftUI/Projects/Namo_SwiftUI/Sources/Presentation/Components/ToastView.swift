//
//  ToastView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 3/16/24.
//

import SwiftUI

struct ToastView: View {
    
    let toastMessage: String
    let bottomPadding: CGFloat
    
    var body: some View {
        Rectangle()
            .foregroundStyle(.black).opacity(0.3)
            .frame(width: 250, height: 52)
            .cornerRadius(10)
            .transition(.move(edge: .bottom).combined(with: .opacity))
            .padding(.bottom, bottomPadding)
            .overlay(
                
                Text(toastMessage)
                    .font(Font.pretendard(.bold, size: 14))
                    .foregroundStyle(.white)
                    .padding(.bottom, bottomPadding)
            )
    }
}

#Preview {
    ToastView(toastMessage: "토스트 메시지", bottomPadding: 150)
}
