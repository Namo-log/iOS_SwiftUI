//
//  SectionTabBar.swift
//  FeatureMoimInterface
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem

public struct SectionTabBar: View {
    @Binding var tabIndex: Int
    
    @State private var offset: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    public var body: some View {
        VStack {
            HStack(spacing: 96) {
                TabBarButton(text: "모임 일정", isSelected: .constant(tabIndex == 0))
                    .overlay {
                        GeometryReader { proxy in
                            Color.clear.contentShape(Rectangle())
                                .onAppear {
                                    offset = proxy.frame(in: .named("OuterView")).minX - 10
                                    width = proxy.frame(in: .named("OuterView")).width + 20
                                }
                                .onTapGesture {
                                    withAnimation {
                                        tabIndex = 0
                                        offset = proxy.frame(in: .named("OuterView")).minX - 10
                                        width = proxy.frame(in: .named("OuterView")).width + 20
                                    }
                                }
                        }
                    }
                
                TabBarButton(text: "친구 리스트", isSelected: .constant(tabIndex == 1))
                    .overlay {
                        GeometryReader { proxy in
                            Color.clear.contentShape(Rectangle())
                                .onTapGesture {
                                    withAnimation {
                                        tabIndex = 1
                                        offset = proxy.frame(in: .named("OuterView")).minX - 10
                                        width = proxy.frame(in: .named("OuterView")).width + 20
                                    }
                                }
                        }
                    }
            }
            
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 1.5)
                .foregroundColor(.mainGray)
                .overlay {
                    Path(CGRect(x: 0, y: 0, width: width, height: 1.5))
                        .offset(x: offset)
                        .foregroundColor(.mainOrange)
                    
                }
        }.coordinateSpace(name: "OuterView")
    }
}

public struct TabBarButton: View {
    let text: String
    
    @Binding var isSelected: Bool
    
    private var seletedColor: Color {
        isSelected ? .mainOrange : .textPlaceholder
    }
    
    public var body: some View {
        Text(text)
            .font(.pretendard(.bold, size: 15))
            .foregroundStyle(seletedColor)
    }
}
