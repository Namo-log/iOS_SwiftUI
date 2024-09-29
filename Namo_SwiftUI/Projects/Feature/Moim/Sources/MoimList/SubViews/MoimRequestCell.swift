//
//  MoimListCell.swift
//  FeatureMoimInterface
//
//  Created by 권석기 on 9/10/24.
//

import SwiftUI
import SharedDesignSystem

struct MoimRequestCell: View {
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                Image(asset: SharedDesignSystemAsset.Assets.mongi1)
                    .resizable()
                    .frame(width: 48, height: 48)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("2024.08.07 (수) 12:00")
                        .font(.pretendard(.regular, size: 12))
                        .foregroundStyle(Color.mainText)
                    
                    
                    Text("나모 3기 회식")
                        .font(.pretendard(.bold, size: 15))
                        .foregroundStyle(Color.mainText)
                    
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
                
                Image(asset: SharedDesignSystemAsset.Assets.btnAddRecord)
                
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 20)
        }
        .frame(maxWidth: .infinity, minHeight: 88)
        .background(Color.itemBackground)
        .cornerRadius(8)
        .shadow(
            color: Color.black.opacity(0.1),
            radius: 2
        )
    }
}

