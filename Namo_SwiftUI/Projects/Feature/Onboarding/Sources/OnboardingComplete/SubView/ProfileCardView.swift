//
//  ProfileCardView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/16/24.
//

import SwiftUI
import SharedDesignSystem
import SharedUtil

public struct ProfileCardView: View {
    
    var profileImage: Image?
    var nickname: String?
    var userCode: String?
    var name: String?
    var birthDate: Date?
    var bio: String?
    var favoriteColor: Color?
    
    public init(
        profileImage: Image? = nil,
        nickname: String? = nil,
        userCode: String? = nil,
        name: String? = nil,
        birthDate: Date? = nil,
        bio: String? = nil,
        favoriteColor: Color? = nil
    ) {
        self.profileImage = profileImage
        self.nickname = nickname
        self.userCode = userCode
        self.name = name
        self.birthDate = birthDate
        self.bio = bio
        self.favoriteColor = favoriteColor
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 24) {
                // 상단 프로필
                HStack {
                    Image(asset: SharedDesignSystemAsset.Assets.appLogo)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.trailing, 20)
                    VStack(alignment: .leading, spacing: 8) {
                        Text("\(nickname ?? "user") \(userCode ?? "#0000")")
                            .font(.pretendard(.bold, size: 20))
                            .foregroundColor(.mainText)
                        Text(name ?? "user")
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
                            Text(favoriteColor?.description ?? "favColor")
                                .font(.pretendard(.regular, size: 15))
                                .foregroundColor(.mainText)
                            Circle()
                                .fill(favoriteColor ?? .namoOrange)
                                .frame(width: 18, height: 18)
                        }
                    }
                    HStack {
                        Text("생년월일")
                            .font(.pretendard(.bold, size: 15))
                            .foregroundColor(.mainText)
                        Spacer()
                        Text(birthDate?.toYMDString() ?? "birthDate")
                            .font(.pretendard(.regular, size: 15))
                            .foregroundColor(.mainText)
                    }
                    VStack(alignment: .leading, spacing: 8) {
                        Text("한 줄 소개")
                            .font(.pretendard(.bold, size: 15))
                            .foregroundColor(.mainText)
                        Text(bio ?? "작성된 한 줄 소개가 없습니다.")
                            .font(.pretendard(bio != nil ? .bold : .regular, size: 15))
                            .foregroundColor(bio != nil ? .mainText : .textPlaceholder)
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
