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
    
    @Perception.Bindable var store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
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
                    switch store.favoriteColorState {
                    case .blank:
                        Image(asset: SharedDesignSystemAsset.Assets.icFavColor)
                    case .filled, .valid:
                        Image(asset: SharedDesignSystemAsset.Assets.icFavColorValid)
                    case .invalid:
                        Image(asset: SharedDesignSystemAsset.Assets.icFavColorInvalid)
                    }
                })
                .offset(x: 52, y: 52)
            }
        }
    }
}
