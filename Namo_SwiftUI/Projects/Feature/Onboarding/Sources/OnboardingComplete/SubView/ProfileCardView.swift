//
//  ProfileCardView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import ComposableArchitecture
import SharedDesignSystem
import SharedUtil
import Kingfisher

public struct ProfileCardView: View {
    
    var store: StoreOf<OnboardingCompleteStore>
    
    public init(store: StoreOf<OnboardingCompleteStore>) {
        self.store = store
    }
    
    public var body: some View {
        WithPerceptionTracking {
            ZStack {
                VStack(spacing: 24) {
                    // 상단 프로필
                    HStack {
                        if let url = store.imageURL {
                            KFImage(URL(string: url))
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(.trailing, 20)
                        } else {
                            Image(asset: SharedDesignSystemAsset.Assets.appLogo)
                                .resizable()
                                .frame(width: 100, height: 100)
                                .padding(.trailing, 20)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("\(store.presentInfo?.nickname ?? "user") \(store.presentInfo?.tag ?? "#0000")")
                                .font(.pretendard(.bold, size: 20))
                                .foregroundColor(.mainText)
                            Text(store.presentInfo?.name ?? "user")
                                .font(.pretendard(.regular, size: 20))
                                .foregroundColor(.mainText)
                        }
                    }
                    // 하단 프로필
                    VStack(alignment: .leading, spacing: 16) {
                        HStack {
                            Text("좋아하는 색상")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundColor(.mainText)
                            Spacer()
                            HStack(spacing: 8) {
                                
                                Text(PalleteColor(rawValue: store.presentInfo?.colorId ?? 1)?.name ?? "favoriteColor")
                                    .font(.pretendard(.regular, size: 15))
                                    .foregroundColor(.mainText)
                                Circle()
                                    .fill(PalleteColor(rawValue: store.presentInfo?.colorId ?? -1)?.color ?? .namoOrange)
                                    .frame(width: 18, height: 18)
                            }
                        }
                        HStack {
                            Text("생년월일")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundColor(.mainText)
                            Spacer()
                            Text(store.presentInfo?.birthday ?? "birthDate")
                                .font(.pretendard(.regular, size: 15))
                                .foregroundColor(.mainText)
                        }
                        VStack(alignment: .leading, spacing: 8) {
                            Text("한 줄 소개")
                                .font(.pretendard(.bold, size: 15))
                                .foregroundColor(.mainText)
                            Text(store.presentInfo?.bio ?? "작성된 한 줄 소개가 없습니다.")
                                .font(.pretendard(.regular, size: 15))
                                .foregroundColor(store.presentInfo?.bio != nil ? .mainText : .textPlaceholder)
                        }
                    }
                }
                .padding(30)
            }
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
        }
    }
}
