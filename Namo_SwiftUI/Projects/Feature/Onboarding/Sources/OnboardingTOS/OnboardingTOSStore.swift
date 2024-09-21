//
//  OnboardingTOSStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/21/24.
//

import ComposableArchitecture
import SwiftUI

@Reducer
public struct OnboardingTOSStore {
    
    public init() {}
    
    @ObservableState
    public struct State: Equatable {
        /// 이용 약관
        var termsOfServiceAgreement: Bool = false
        /// 개인정보 수집 및 이용
        var personalDataConsent: Bool = false
        /// 위치 서비스 이용 약관
        var locationServiceAgreement: Bool = false
        /// 앱 푸쉬 알림 수신 동의
        var pushNotificationConsent: Bool = false
        
        public init() {
            // 체크 로직 수행
        }
    }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
//        case tosListItemCheckCircleTapped(AgreementItem)
        case tosListItemLinkTapped(AgreementItem)
    }
    
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce {
            state,
            action in
            switch action {
                
            case .binding:
                return .none
//            case .tosListItemCheckCircleTapped(let item):
                
            case .tosListItemLinkTapped(let item):
                let item = item as AgreementItem
                if let urlString = item.URL,
                   let url = URL(string: urlString),
                   UIApplication.shared.canOpenURL(url) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url)
                    }
                }
                return .none
            }
        }
    }
}
