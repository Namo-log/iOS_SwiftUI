import SwiftUI
import SharedDesignSystem
import FeatureMoimInterface

@main
struct FeautureMoimExampleApp: App {
    var body: some Scene {
        WindowGroup {
                MoimListView()
                .namoNabBar(left: {
                    Text("Group Calendar")
                        .font(.pretendard(.bold, size: 22))
                        .foregroundStyle(.black)
                }, right: {
                    Image("ic_notification")
                })
        }
    }
}

