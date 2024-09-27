//
//  NamoPallete.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem

public struct NamoPallete: View {
    
    @Binding var selectedColor: Color?
    let itemName: String
    let colors: [Color]
    
    var columns: [GridItem] {
        let columnCount = colors.count >= 5 ? 5 : colors.count
        return Array(repeating: GridItem(.flexible(minimum: 20)), count: columnCount)
    }
    
    public init(
        selectedColor: Binding<Color?>,
        itemName: String,
        colors: [Color]
    ) {
        self._selectedColor = selectedColor
        self.itemName = itemName
        self.colors = colors
    }
    
    
    public var body: some View {
        HStack {
            VStack {
                Text(itemName)
                    .font(.pretendard(.bold, size: 15))
                    .foregroundColor(.mainText)
                Spacer()
            }
            
            Spacer()
            
            LazyVGrid(columns: columns, alignment: .trailing, spacing: 16) {
                ForEach(colors, id: \.self) { color in
                    Circle()
                        .fill(color)
                        .frame(width: 24, height: 24)
                        .overlay {
                            if color == self.selectedColor {
                                Image(asset: SharedDesignSystemAsset.Assets.checkMark)
                                    .frame(width: 24, height: 24)
                            }
                        }
                        .onTapGesture {
                            selectedColor = color
                        }
                }
            }
        }
    }
}
