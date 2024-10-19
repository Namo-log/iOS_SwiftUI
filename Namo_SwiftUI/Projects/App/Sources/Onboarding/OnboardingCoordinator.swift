//
//  OnBoardingCoordinator.swift
//  Namo_SwiftUI
//
//  Created by 권석기 on 9/20/24.
//

import Foundation
import ComposableArchitecture
import TCACoordinators
import FeatureOnboarding
import DomainAuthInterface
import SharedUtil

@Reducer(state: .equatable)
enum OnboardingScreen {
    case splash(OnboardingSplashStore)
    case login(OnboardingLoginStore)
    case agreement(OnboardingTOSStore)
    case userInfo(OnboardingInfoInputStore)
    case signUpCompletion(OnboardingCompleteStore)
}

@Reducer
struct OnboardingCoordinator {
    
    @Dependency(\.authClient) var authClient
    private let remoteConfig = RemoteConfigManager()
    
    @ObservableState
    struct State: Equatable {
        
        var routes: [Route<OnboardingScreen.State>]
        // 버전 체크 여부 플래그
        var hasPerformedVersionCheck: Bool = false
        // 버전 업데이트 필요 표시 플래그
        @Shared(.inMemory(SharedKeys.showUpdateRequired.rawValue)) var showUpdateRequired: Bool = false
        // 로그인 체크 여부 플래그
        var hasPerformedLoginCheck: Bool = false
        
        static let initialState: State = .init(
            routes: [.root(.splash(.init()))]
        )
        
        static func routedState(_ routes: [Route<OnboardingScreen.State>]) -> State {
            var initState = initialState
            initState.routes.append(contentsOf: routes)
            return initState
        }
    }
    
    enum Action {
        case router(IndexedRouterActionOf<OnboardingScreen>)
        
        // 초기 체크
        case initialCheck
        // 버전 체크
        case versionCheck
        // 버전 체크 결과
        case versionCheckResponse(Result<Bool, Error>)
        // 로그인 체크
        case loginCheck
        // 로그인 화면
        case goToLoginScreen
        // 약관 동의 화면
        case goToAgreementScreen
        // 유저 정보 작성 화면
        case goToUserInfoScreen
        // 회원가입 완료 화면
        case goToSignUpCompletion(info: SignUpInfo, imageURL: String?)
        // 메인 화면
        case goToMainScreen
    }
    
    var body: some ReducerOf<Self> {
        
        Reduce<State, Action> { state, action in
            switch action {
            
                // 화면 라우팅 from routeAction
            case .router(.routeAction(_, action: let action)):
                switch action {
                    
                    // 약관 동의 화면으로 이동
                case .login(.goToNextScreen):
//                    return .send(.goToAgreementScreen)
                    return .send(.loginCheck)
                    
                    // 유저 정보 입력 화면으로 이동
                case .agreement(.goToNextScreen):
//                    return .send(.goToUserInfoScreen)
                    return .send(.loginCheck)
                    
                    // 회원가입 완료 화면으로 이동
                case let .userInfo(.goToNextScreen(info, imageURL)):
                    return .send(.goToSignUpCompletion(info: info, imageURL: imageURL))
                    
                    // 메인 화면으로 이동
                case .signUpCompletion(.goToNextScreen):
                    return .send(.goToMainScreen)
                    
                default:
                    return .none
                }
            
                // 초기 체크 -> 버전 체크로 시작
            case .initialCheck:
                return .send(.versionCheck)
                
                // 버전 체크
            case .versionCheck:
                guard !state.hasPerformedVersionCheck else { return .none }
                state.hasPerformedVersionCheck = true

                return .run { send in
                    do {
                        let updateRequired = try await remoteConfig.checkUpdateRequired()
//                        if let baseUrl = try await remoteConfig.getBaseUrl() {
//                            // TODO: BaseURL의 용도 체크 필요
//                        } else {
//                            throw NSError(domain: "API 테스트 실패", code: 1001)
//                        }
                        await send(.versionCheckResponse(.success(updateRequired)))
                    } catch {
                        await send(.versionCheckResponse(.failure(error)))
                    }
                }
                
            case .versionCheckResponse(.success(let updateRequired)):
                state.showUpdateRequired = updateRequired
                // 로그인 체크로 라우팅
                return .send(.loginCheck)
                
            case .versionCheckResponse(.failure(let error)):
                print("최소 버전 가져오기 실패: \(error.localizedDescription)")
                // TODO: 앱 끌건지 체크 필요
                return .none           
                
                // 로그인 체크 결과 라우팅
            case .loginCheck:
                
                switch authClient.userStatusCheck() {
                    
                case .logout:
                    return .send(.goToLoginScreen)
                    // 토큰 O, 약관 X, 정보입력 X
                case .loginWithoutEverything:
                    return .send(.goToAgreementScreen)
                    // 토큰 O, 약관 X
                case .loginWithoutAgreement:
                    return .send(.goToAgreementScreen)
                    // 토큰 O, 약관 O, 정보입력 X
                case .loginWithoutUserInfo:
                    return .send(.goToUserInfoScreen)
                    // 토큰 O, 약관 O, 정보입력 O
                case .loginWithAll:
                    return .send(.goToMainScreen)
                }
                
            case .goToLoginScreen:
                state.routes = [.root(.login(.init()), embedInNavigationView: true)]
                return .none
                
            case .goToAgreementScreen:
                state.routes = [
                    .root(.login(.init())),
                    .push(.agreement(.init()))
                ]
                return .none
                
            case .goToUserInfoScreen:
                state.routes = [
                    .root(.login(.init())),
                    .push(.userInfo(.init()))
                ]
                return .none
                
            case let .goToSignUpCompletion(info, imageURL):
                state.routes.push(.signUpCompletion(.init(result: info, imageURL: imageURL)))
                return .none
                
            case .goToMainScreen:
                // 해당 action은 AppCoordinator에서 체크합니다
                return .none
                
            default:
                return .none
            }
        }
        .forEachRoute(\.routes, action: \.router)
    }
}
