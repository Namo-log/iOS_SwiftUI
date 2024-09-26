import SwiftUI
import ComposableArchitecture
import FeatureOnboarding

@main
struct FeatureFriendExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
            OnboardingInfoInputView(store: Store(initialState: OnboardingInfoInputStore.State(name: "테스트")) {
                OnboardingInfoInputStore()
//                    ._printChanges()
            })
//            OnboardingLoginView(store: Store(initialState: OnboardingLoginStore.State()) {
//                OnboardingLoginStore()
//                    ._printChanges()
//            })
//            OnboardingSplashView(store: Store(initialState: OnboardingSplashStore.State()) {
//                OnboardingSplashStore()
//                    ._printChanges()
//            })
        }
    }
}
