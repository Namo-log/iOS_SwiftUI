//
//  OnboardingLoginStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/18/24.
//

import ComposableArchitecture

import DomainAuth
import DomainAuthInterface
import Core

@Reducer
public struct OnboardingLoginStore {
    
    public init() {}
    
//    @ObservableState // 화면에 연결되어 재렌더링 매개체가 되는 경우에만 활성화
    public struct State: Equatable {
        
        public init() {}
    }
    
    public enum Action {
        case kakaoLoginButtonTapped
        case naverLoginButtonTapped
        case appleLoginButtonTapped
        case namoKakaoLoginResponse(SocialSignInRequestDTO)
        case namoNaverLoginResponse(SocialSignInRequestDTO)
        case namoAppleLoginResponse(AppleSignInRequestDTO)
    }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .kakaoLoginButtonTapped:
                print("kakao")
                return .run { send in
                    guard let data = await authClient.kakaoLogin() else { return }
                    let reqData = data as SocialSignInRequestDTO
                    await send(.namoKakaoLoginResponse(reqData))
                }
                
            case .naverLoginButtonTapped:
                print("naver")
                return .run { send in
                    guard let data = await authClient.naverLogin() else { return }
                    let reqData = data as SocialSignInRequestDTO
                    await send(.namoNaverLoginResponse(reqData))
                }
                
            case .appleLoginButtonTapped:
                print("apple")
                return .run { send in
                    guard let data = await authClient.appleLogin() else { return }
                    let reqData = data as AppleSignInRequestDTO
                    await send(.namoAppleLoginResponse(reqData))
                }
                
            case .namoKakaoLoginResponse(let reqData):
                print("namo kakao")
                return .run { send in
                    if let result = try await authClient.reqSignInWithKakao(reqData) {
                        print("result as Token type is \(result)")
                        
                    } else {
                        print("인생은 니뜻대로 되지않는단다")
                    }
                }
                
            case .namoNaverLoginResponse(let reqData):
                print("namo naver")
                return .run { send in
                    if let result = try await authClient.reqSignInWithNaver(reqData) {
                        print("result as Token type is \(result)")
                    } else {
                        print("인생은 니뜻대로 되지않는단다")
                    }
                }
                
            case .namoAppleLoginResponse(let reqData):
                print("namo apple")
                return .run { send in
                    let result = try await authClient.reqSignInWithApple(reqData)
                    print("result as Token type is \(result)")
                }
            }
        }
    }
}
