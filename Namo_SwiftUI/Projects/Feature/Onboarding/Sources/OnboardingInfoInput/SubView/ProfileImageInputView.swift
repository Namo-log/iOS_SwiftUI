//
//  ProfileImageInputView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem

public struct ProfileImageInputView: View {
    
    var store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
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
        .onTapGesture {
            store.send(.addImageButtonTapped)
        }
        .overlay {
            Button(action: {
                store.send(.addFavoriteColorButtonTapped)
            }, label: {
                Image(asset: SharedDesignSystemAsset.Assets.icFavColor)
            })
            .offset(x: 52, y: 52)
        }
    }
}
