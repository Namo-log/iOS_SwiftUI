//
//  Participant.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/10/24.
//

import SwiftUI
import SharedDesignSystem

struct Participant: View {
    let name: String
    let color: Color
    let isOwner: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 9) {
                Circle()
                    .frame(width: 14, height: 14)
                    .foregroundColor(color)
                    .overlay {
                        if isOwner {
                            Image(asset: SharedDesignSystemAsset.Assets.icCrown)
                        }
                    }
                
                Text(name)
                    .font(.pretendard(.regular, size: 15))
                    .foregroundStyle(Color.mainText)
            }
            .padding(.vertical, 4)
            .padding(.leading, 6)
            .padding(.trailing, 12)
        }
        .background(Color.itemBackground)
        .cornerRadius(13)
        .shadow(
            color: Color.black.opacity(0.2),
            radius: 4
        )        
    }
}

