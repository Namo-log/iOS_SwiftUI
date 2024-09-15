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
    
    var columns: [GridItem] {
        let columnCount = colors.count >= 5 ? 5 : colors.count
        return Array(repeating: GridItem(.flexible()), count: columnCount)
    }
    
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
                
            LazyVGrid(columns: columns, alignment: .trailing, spacing: 20) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 24, height: 24)
                }
            }
        }
    }
}
