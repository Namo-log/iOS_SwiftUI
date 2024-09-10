//
//  MoimListView.swift
//  FeatureMoim
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem

public struct MoimListView: View {
    @State private var showingSheet = false
    @State private var isCheck = false
    
    public init() {}
    
    public var body: some View {
        ScrollView {
            HStack(spacing: 8) {
                Spacer()
                
                Text("지난 모임 일정 숨기기")
                    .font(.pretendard(.regular, size: 12))
                    .foregroundStyle(Color.textDisabled)
                
                CheckButton(isCheck: $isCheck)
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
                showingSheet = true
            }
        }
        .sheet(isPresented: $showingSheet, content: {
            MoimCreateView()
                .presentationDetents([.height(700)])
        })
    }
}
