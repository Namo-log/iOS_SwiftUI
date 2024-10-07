//
//  OnboardingLoginStore.swift
//  FeatureOnboarding
//
//  Created by 박민서 on 9/18/24.
//

import ComposableArchitecture
import Foundation
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
        case loginFailed(String)
    }
    
    @Dependency(\.authClient) var authClient
    
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
                
            case .kakaoLoginButtonTapped:
                print("kakao")
                return .run { send in
                    guard let data = await authClient.kakaoLogin() else {
                        await send(.loginFailed("kakao login failed"))
                        return
                    }
                    let reqData = data as SocialSignInRequestDTO
                    await send(.namoKakaoLoginResponse(reqData))
                }
                
            case .naverLoginButtonTapped:
                print("naver")
                return .run { send in
                    guard let data = await authClient.naverLogin() else {
                        await send(.loginFailed("naver login failed"))
                        return
                    }
                    let reqData = data as SocialSignInRequestDTO
                    await send(.namoNaverLoginResponse(reqData))
                }
                
            case .appleLoginButtonTapped:
                print("apple")
                return .run { send in
                    guard let data = await authClient.appleLogin() else {
                        await send(.loginFailed("apple login failed"))
                        return
                    }
                    let reqData = data as AppleSignInRequestDTO
                    await send(.namoAppleLoginResponse(reqData))
                }
                
            case .namoKakaoLoginResponse(let reqData):
                print("namo kakao")
                return .run { send in
                    do {
                        let result = try await authClient.reqSignInWithKakao(reqData)
                        let tokens: Tokens = (result.accessToken, result.refreshToken)
                        authClient.setLoginState(.kakao, with: tokens)
                    } catch {
                        await send(.loginFailed(error.localizedDescription))
                    }
                }
                
            case .namoNaverLoginResponse(let reqData):
                print("namo naver")
                return .run { send in
                    do {
                        let result = try await authClient.reqSignInWithNaver(reqData)
                        let tokens: Tokens = (result.accessToken, result.refreshToken)
                        authClient.setLoginState(.naver, with: tokens)
                    } catch {
                        await send(.loginFailed(error.localizedDescription))
                    }
                }
                
            case .namoAppleLoginResponse(let reqData):
                print("namo apple")
                return .run { send in
                    do {
                        let result = try await authClient.reqSignInWithApple(reqData)
                        let tokens: Tokens = (result.accessToken, result.refreshToken)
                        
                        authClient.setLoginState(.apple, with: tokens)
                        authClient.setUserId(userId: result.userId)
                    } catch {
                        await send(.loginFailed(error.localizedDescription))
                    }
                }
                
            case .loginFailed(let errorDesc):
                print("임시 에러 처리: \(errorDesc)")
                return .none
            }
        }
    }
}
