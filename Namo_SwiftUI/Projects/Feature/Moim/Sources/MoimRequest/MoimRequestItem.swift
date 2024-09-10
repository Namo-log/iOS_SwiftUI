//
//  MoimRequestItem.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI
import SharedDesignSystem

struct MoimRequestItem: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(asset: SharedDesignSystemAsset.Assets.appLogoSquare2)
                    .frame(width: 48, height: 48)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("2024.08.07 (수) 12:00")
                        .font(.pretendard(.regular, size: 12))
                        .foregroundStyle(Color.mainText)
                    
                    Text("나모 3기 회식")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                        .lineLimit(1)
                    
                    HStack {
                        Text("10")
                            .font(.pretendard(.bold, size: 12))
                            .foregroundStyle(Color.mainText)
                        
                        Text("코코아, 유즈, 뚜뚜, 고흐, 초코, 다나, 반디, 램프, 연현 let's go")
                            .font(.pretendard(.regular, size: 12))
                            .foregroundStyle(Color.mainText)
                            .lineLimit(1)
                    }
                    
                }
                
                Spacer(minLength: 0)
            }
            .padding(.leading, 16)
            .padding(.trailing, 20)
            .padding(.vertical, 12)
            .background(Color.itemBackground)
            
            HStack {
                Button(
                    action: {
                        
                    }, label: {
                        Text("수락")
                            .frame(maxWidth: .infinity)
                    }
                )
                .tint(Color.mainOrange)
                
                Divider()
                    .background(Color.textUnselected)
                    .frame(width: 1, height: 32)
                
                Button(
                    action: {
                        
                    }, label: {
                        Text("거절")
                            .frame(maxWidth: .infinity)
                    }
                )
                .tint(Color.colorBlack)
            }
            .background(Color.white)
            .frame(height: 52)
            
        }
        .frame(height: 124)
        .frame(maxWidth: .infinity)
        .background()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.1), radius: 4)
    }
}

#Preview {
    MoimRequestItem()
}
