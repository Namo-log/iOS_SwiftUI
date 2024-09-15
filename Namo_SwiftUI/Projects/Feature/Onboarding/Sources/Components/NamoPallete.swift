//
//  NamoPallete.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem

public struct NamoPallete: View {
    
    let itemName: String
    let colors: [Color]
    
    let columns = [
            GridItem(.flexible()), 
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    public init(itemName: String, colors: [Color]) {
        self.itemName = itemName
        self.colors = colors
    }
    
    public var body: some View {
        HStack {
            Text(itemName)
                .font(.pretendard(.bold, size: 15))
                .foregroundColor(.mainText)
            
            Spacer()
                
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}
