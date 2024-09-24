import SwiftUI
import SharedDesignSystem
import FeatureMoim

@main
struct FeautureMoimExampleApp: App {
    var body: some Scene {
        WindowGroup {
            //            FriendInviteView()
            MoimView(store: .init(initialState: .init(), reducer: {
                MoimViewStore()
            }))
            //            MoimRequestView()
            //            MoimEditView()
            //            DiaryEditView()
        }
    }
}

