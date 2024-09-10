//
//  SectionTabBar.swift
//  FeatureMoimInterface
//
//  Created by 권석기 on 9/6/24.
//

import SwiftUI
import SharedDesignSystem
import Factory

public struct SectionTabBar<Content: View>: View {
    @Binding var tabIndex: Int
    
    @State private var offset: CGFloat = .zero
    @State private var width: CGFloat = .zero
    
    private let content: () -> Content
    private let tabTitle: [String]
    
    public init(tabIndex: Binding<Int>,
                tabTitle: [String],
                @ViewBuilder content: @escaping () -> Content) {
        self._tabIndex = tabIndex
        self.tabTitle = tabTitle
        self.content = content
    }
    
    public var body: some View {
        VStack {
            HStack(spacing: 96) {
                ForEach(Array(tabTitle.enumerated()), id: \.element) { (index, title) in
                    TabBarButton(text: title, isSelected: .constant(tabIndex == index))
                        .overlay {
                            GeometryReader { proxy in
                                Color.clear.contentShape(Rectangle())
                                    .onAppear {
                                        offset = proxy.frame(in: .named("OuterView")).minX - 10
                                        width = proxy.frame(in: .named("OuterView")).width + 20
                                    }
                                    .onTapGesture {
                                        withAnimation {
                                            tabIndex = index
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
            }
            .coordinateSpace(name: "OuterView")
            
            content()
        }
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
