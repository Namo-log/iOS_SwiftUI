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
        /// 전체 동의
        var entireAgreement: Bool = false
        /// 이용 약관
        var termsOfServiceAgreement: Bool = false
        /// 개인정보 수집 및 이용
        var personalDataConsent: Bool = false
        /// 위치 서비스 이용 약관
        var locationServiceAgreement: Bool = false
        /// 앱 푸쉬 알림 수신 동의
        var pushNotificationConsent: Bool = false
        /// 확인 버튼 활성화 상태
        var nextButtonIsEnabled: Bool = false
        
        public init() {}
    }
    
    public enum Action {
        /// 각 약관 동의 체크 버튼 탭
        case tosListItemCheckCircleTapped(AgreementItem)
        /// 각 약관 설명 `>` 버튼 탭
        case tosListItemLinkTapped(AgreementItem)
        /// 약관 전체 상황 체크, 반영
        case checkAgreements
        /// 확인 버튼 탭
        case nextButtonTapped
        /// 다음 화면으로
        case goToNextScreen
    }
    
    public var body: some ReducerOf<Self> {
        
        Reduce { state, action in
            switch action {
                
            case .tosListItemCheckCircleTapped(let item):
                switch item {
                    
                case .agreeAll:
                    let newValue = !state.entireAgreement
                    state.entireAgreement = newValue
                    state.termsOfServiceAgreement = newValue
                    state.personalDataConsent = newValue
                    state.locationServiceAgreement = newValue
                    state.pushNotificationConsent = newValue
                    
                case .termsOfServiceAgreement:
                    state.termsOfServiceAgreement.toggle()
                case .personalDataConsent:
                    state.personalDataConsent.toggle()
                case .locationServiceAgreement:
                    // TODO: 위치 허용 부분 추후 추가
                    state.locationServiceAgreement.toggle()
                case .pushNotificationConsent:
                    // TODO: 푸쉬 알림 허용 부분 추후 추가
                    state.pushNotificationConsent.toggle()
                }
                
                return .send(.checkAgreements)
                
            case .tosListItemLinkTapped(let item):
                let item = item as AgreementItem
                // URL 체크 후 웹뷰 오픈
                if let urlString = item.URL,
                   let url = URL(string: urlString),
                   UIApplication.shared.canOpenURL(url) {
                    DispatchQueue.main.async {
                        UIApplication.shared.open(url)
                    }
                }
                return .none
                
            case .checkAgreements:
                // 필수 약관 동의 여부 판단
                let requiredAgreementsChecked: Bool = state.termsOfServiceAgreement && state.personalDataConsent
                // 모든 약관의 전체 동의 여부 판단
                let allAgreementsChecked: Bool = requiredAgreementsChecked && state.locationServiceAgreement && state.pushNotificationConsent
                // 약관 동의 여부 반영
                state.entireAgreement = allAgreementsChecked
                state.nextButtonIsEnabled = requiredAgreementsChecked
                return .none
            
            case .nextButtonTapped:
                if state.nextButtonIsEnabled {
                    print("allowed to go next")
                    return .send(.goToNextScreen)
                } else {
                    print("not allowed to go next")
                    return .none
                }
                
            case .goToNextScreen:
                print("TOS completed -> goToNextScreen")
                return .none
            }
        }
    }
}
