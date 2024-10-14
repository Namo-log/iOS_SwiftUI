//
//  ProfileImageInputView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import PhotosUI
import ComposableArchitecture
import SharedDesignSystem

public struct ProfileImageInputView: View {
    
    @Perception.Bindable var store: StoreOf<OnboardingInfoInputStore>
    
    public init(store: StoreOf<OnboardingInfoInputStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            PhotosPicker(selection: $store.profileImageItem) {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                        .frame(width: 120, height: 120)
                        .foregroundColor(.mainGray)
                    if let selectedImage = store.profileImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(.rect(cornerRadius: 24))
                    } else {
                        Image(asset: SharedDesignSystemAsset.Assets.icImage)
                            .resizable()
                            .frame(width: 28, height: 28)
                    }
                }
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
                            .overlay {
                                Circle()
                                    .frame(width: 32, height:32)
                                    .foregroundColor(store.favoriteColor)
                            }
                    case .invalid:
                        Image(asset: SharedDesignSystemAsset.Assets.icFavColorInvalid)
                    }
                })
                .offset(x: 52, y: 52)
            }
        }
    }
}
