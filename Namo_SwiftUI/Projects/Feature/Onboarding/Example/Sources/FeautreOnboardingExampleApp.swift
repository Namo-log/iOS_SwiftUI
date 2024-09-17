import SwiftUI
import ComposableArchitecture
import FeatureOnboarding

@main
struct FeatureFriendExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
//            OnboardingLoginView(store: Store(initialState: OnboardingLoginStore.State()) {
//                OnboardingLoginStore()
//                    ._printChanges()
//            })
            OnboardingSplashView(store: Store(initialState: OnboardingSplashStore.State()) {
                OnboardingSplashStore()
                    ._printChanges()
            })
        }
    }
}
