//
//  FloatingButton.swift
//  SharedDesignSystem
//
//  Created by 권석기 on 9/10/24.
//

import SwiftUI

public struct FloatingButton: View {
    
    let action: (() -> Void)?
    
    public init(action: (() -> Void)? = nil) {
        self.action = action
    }
    
    public var body: some View {
        Button(
            action: {
                action?()
            },
            label: {
                Image(asset: SharedDesignSystemAsset.Assets.floatingAdd)
                    .resizable()
                    .frame(width: 56, height: 56)
            }
        )
        .padding(.trailing, 24)
        .padding(.bottom, 24)
    }
}

#Preview {
    FloatingButton()
}
