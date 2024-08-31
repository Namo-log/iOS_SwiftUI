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
    
    public init(isPresented: Binding<Bool>, title: String) {
        self._isPresented = isPresented
        self.title = title
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
                    
                    Spacer()
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
    func toast(isPresented: Binding<Bool>, title: String) -> some View {
        modifier(NamoToastViewModifier(isPresented: isPresented, title: title))
    }
}
