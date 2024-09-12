import SwiftUI
import ComposableArchitecture
import FeatureOnboarding

@main
struct FeatureFriendExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
            OnboardingLoginView()
        }
    }
}

#Preview {
    OnboardingLoginView()
}
