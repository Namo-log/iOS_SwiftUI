//
//  TOSListView.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/13/24.
//

import SwiftUI
import SharedDesignSystem
import SharedUtil

struct TOSListView: View {
    @State var toggle: Bool = true
    
    var body: some View {
        VStack {
            CheckItem(agreementItem: .agreeAll, toggleValue: .constant(true))
            
            Divider()
                .foregroundStyle(Color.textPlaceholder)
                .frame(height: 1.5)
            
            CheckItem(agreementItem: .termsOfServiceAgreement, toggleValue: .constant(true))
            
            CheckItem(agreementItem: .personalDataConsent, toggleValue: .constant(true))
            
            CheckItem(agreementItem: .locationServiceAgreement, toggleValue: .constant(false))
            
            CheckItem(agreementItem: .pushNotificationConsent, toggleValue: .constant(false))
        }
        .padding(.horizontal, 45)
    }
}

// TODO: 추후 Domain으로 이전 필요
/// 약관 동의에 사용되는 약관 모델입니다.
public enum AgreementItem {
    
    /// 전체 동의
    case agreeAll
    /// 이용 약관
    case termsOfServiceAgreement
    /// 개인정보 수집 및 이용
    case personalDataConsent
    /// 위치 서비스 이용 약관
    case locationServiceAgreement
    /// 앱 푸쉬 알림 수신 동의
    case pushNotificationConsent
    
    
    /// 약관 제목
    public var title: String {
        switch self {
            
        case .agreeAll:
            return "전체 동의"
        case .termsOfServiceAgreement:
            return "이용 약관"
        case .personalDataConsent:
            return "개인정보 수집 및 이용"
        case .locationServiceAgreement:
            return "위치 서비스 이용 약관"
        case .pushNotificationConsent:
            return "앱 푸쉬 알림 수신 동의"
        }
    }
    /// 약관 링크
    public var URL: String? {
        switch self {
        case .termsOfServiceAgreement:
            return "https://agreeable-streetcar-8e8.notion.site/30d9c6cf5b9f414cb624780360d2da8c"
        case .personalDataConsent:
            return "https://agreeable-streetcar-8e8.notion.site/ca8d93c7a4ef4ad98fd6169c444a5f32"
        case .agreeAll, .locationServiceAgreement, .pushNotificationConsent:
            return nil
        }
    }
    /// 필수 여부
    public var isRequired: Bool? {
        switch self {
        case .termsOfServiceAgreement, .personalDataConsent:
            return true
        case .locationServiceAgreement, .pushNotificationConsent:
            return false
        case .agreeAll:
            return nil
        }
    }
    /// 필수 여부에 따라 작성된 제목
    public var formattedTitle: String {
        guard let isRequired else { return title }
        let desc = isRequired ? "(필수)" : "(선택)"
        return "\(desc) \(title)"
    }
}

extension TOSListView {
    /// 약관 목록 아이템뷰입니다.
    struct CheckItem: View {
        
        let agreementItem: AgreementItem
        @Binding var toggleValue: Bool
        
        var body: some View {
            HStack(alignment: .center, spacing: 16) {
                Image(asset: toggleValue ? SharedDesignSystemAsset.Assets.isSelectedTrue : SharedDesignSystemAsset.Assets.isSelectedFalse)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        toggleValue.toggle()
                    }
                
                Text(agreementItem.formattedTitle)
                    .lineLimit(1)
                    .foregroundStyle(Color.colorBlack)
                    .font(Font.pretendard(.regular, size: 18))
                
                Spacer(minLength: 0)
                
                Image(asset: SharedDesignSystemAsset.Assets.arrowBasic)
                    .hidden(agreementItem.URL == nil)
//                    .onTapGesture {
//                        if let urlString = agreementItem.URL, let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
//                            DispatchQueue.main.async {
//                                UIApplication.shared.open(url)
//                            }
//                        }
//                    }
                    .disabled(agreementItem.URL == nil)
            }
            .padding(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        }
    }
}
