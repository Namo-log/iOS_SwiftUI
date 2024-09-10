//
//  Participant.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/10/24.
//

import SwiftUI
import SharedDesignSystem

struct Participant: View {
    @State private var dummyFriends = ["코코아", "유즈", "초코", "캐슬", "다나", "연현", "루카", "뚜뚜", "램프", "반디"]
    @State private var dummyColors: [Color] = [.mainGray, .mainOrange, .pink, .blue]
    
    var body: some View {
        VStack {
            HStack(spacing: 8) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundColor(dummyColors.randomElement()!)
                
                Text(dummyFriends.randomElement()!)
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            }
            .padding(.vertical, 4)
            .padding(.horizontal, 12)
        }
        .background(Color.itemBackground)
        .cornerRadius(13)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 2
        )
    }
}

#Preview {
    Participant()
}
