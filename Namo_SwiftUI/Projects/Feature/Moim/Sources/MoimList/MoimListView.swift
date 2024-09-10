//
//  MoimListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem

public struct MoimListView: View {
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            HStack {
                Spacer()
                
                Text("지난 모임 일정 숨기기")
                    .font(.pretendard(.regular, size: 12))
                    .foregroundStyle(Color.textDisabled)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 20)
            
            LazyVStack {
                ForEach(0..<10, id: \.self) { index in
                    MoimListCell()
                        .padding(.top, index != 0 ? 20 : 0)
                }
            }
            .padding(.horizontal, 20)
        }
        .overlay(alignment: .bottomTrailing) {
            FloatingButton {
                print("일정 추가")
            }
        }
    }
}
