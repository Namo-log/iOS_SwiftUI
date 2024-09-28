//
//  NamoToastViewModifier.swift
//  SharedDesignSystem
//
//  Created by 권석기 on 8/31/24.
//

import SwiftUI

public struct NamoToastViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let title: String
    let isTabBarScreen: Bool
    
    public init(isPresented: Binding<Bool>, title: String, isTabBarScreen: Bool = true) {
        self._isPresented = isPresented
        self.title = title
        self.isTabBarScreen = isTabBarScreen
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                VStack {
                    Spacer().frame(minHeight: 108)
                    
                    VStack {
                        Text("\(title)")
                            .font(.pretendard(.bold, size: 14))
                            .foregroundStyle(.white)
                            .padding(16)
                    }
                    .background(Color.black.opacity(0.5))
                    .cornerRadius(8)
                    
                    Spacer(minLength: isTabBarScreen ? 0 : 100)
                }
            }
        }
        .onChange(of: isPresented, perform: { value in
            if value {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        isPresented = false
                    }
                }
            }
        })
    }
}

public extension View {
    func namoToastView(isPresented: Binding<Bool>, title: String) -> some View {
        modifier(NamoToastViewModifier(isPresented: isPresented, title: title))
    }
    
    func namoToastView(isPresented: Binding<Bool>, title: String, isTabBarScreen: Bool) -> some View {
        modifier(NamoToastViewModifier(isPresented: isPresented, title: title, isTabBarScreen: isTabBarScreen))
    }
}
