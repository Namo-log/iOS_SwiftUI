//
//  ProfileImageInputView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem

public struct ProfileImageInputView: View {
    
    var profileImage: Image?
    var isValid: Bool?
    
    public init(profileImage: Image? = nil, isValid: Bool? = nil) {
        self.profileImage = profileImage
        self.isValid = isValid
    }
    
    public var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 24)
                .frame(width: 120, height: 120)
                .foregroundColor(.mainGray)
            
            Image(asset: SharedDesignSystemAsset.Assets.icImage)
                .resizable()
                .frame(width: 28, height: 28)
        }
        .overlay {
            Button(action: {
                print("add image")
            }, label: {
                Image(asset: SharedDesignSystemAsset.Assets.icFavColor)
            })
            .offset(x: 52, y: 52)
        }
    }
}
