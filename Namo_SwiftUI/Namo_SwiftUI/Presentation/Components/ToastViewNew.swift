//
//  ToastViewNew.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/25/24.
//

import SwiftUI

struct ToastViewNew: View {
    
    let toastMessage: String
    let bottomPadding: CGFloat
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            Rectangle()
                .foregroundStyle(.gray)
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
}

#Preview {
    ToastViewNew(toastMessage: "토스트 메시지", bottomPadding: 50)
}
