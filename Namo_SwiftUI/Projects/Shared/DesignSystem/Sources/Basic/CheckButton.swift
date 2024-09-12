//
//  CheckButton.swift
//  SharedDesignSystem
//
//  Created by 권석기 on 9/11/24.
//

import SwiftUI

public struct CheckButton: View {
    @Binding var isCheck: Bool
    
    public init(isCheck: Binding<Bool>) {
        self._isCheck = isCheck
    }
    
    public var body: some View {
        Image(asset: isCheck ? SharedDesignSystemAsset.Assets.checkActive : SharedDesignSystemAsset.Assets.check)
            .onTapGesture {
                isCheck.toggle()
            }
    }
}

#Preview {
    CheckButton(isCheck: .constant(false))
}
