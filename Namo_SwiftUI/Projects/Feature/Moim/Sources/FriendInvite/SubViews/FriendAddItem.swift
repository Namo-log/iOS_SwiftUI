//
//  FriendAddItem.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem

struct FriendAddItem: View {
    @Binding var isSelected: Bool
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(asset: SharedDesignSystemAsset.Assets.appLogo)
                    .cornerRadius(10)
                
                VStack(spacing: 6) {
                    HStack(spacing: 4) {
                        Text("닉네임")
                            .font(.pretendard(.bold, size: 15))
                            .foregroundStyle(Color.mainText)
                        
                        Image(asset: SharedDesignSystemAsset.Assets.icHeart)
                            .resizable()
                            .frame(width: 12, height: 12)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Text("친구가 직접 작성한 한 줄 소개 친구가 직접 작성한 한 줄 소개 친구가 직접 작성한 한 줄 소개친구가 직접 작성한 한 줄 소개")
                            .font(.pretendard(.regular, size: 12))
                            .foregroundStyle(Color.mainText)
                            .lineLimit(1)
                        
                        Spacer()
                    }
                }
                
                Image(asset: isSelected ? SharedDesignSystemAsset.Assets.icAddedSelected : SharedDesignSystemAsset.Assets.icAdded)
            }
            .padding(.leading, 16)
            .padding(.trailing, 24)
            .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity, maxHeight: 72)
        .background(Color.itemBackground)
        .cornerRadius(10)
    }
}

#Preview {
    FriendAddItem(isSelected: .constant(false))
}
