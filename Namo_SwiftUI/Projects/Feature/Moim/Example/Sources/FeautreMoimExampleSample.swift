import SwiftUI
import SharedDesignSystem
import FeatureMoim
import FeatureMoimInterface
import ComposableArchitecture

@main
struct FeautureMoimExampleApp: App {
    var body: some Scene {
        WindowGroup {
            //            FriendInviteView()
//            MoimView(store: .init(initialState: .init(), reducer: {
//                MoimViewStore()
//            }))
            //            MoimRequestView()
            //            MoimEditView()
            //            DiaryEditView()
            MoimScheduleEditView(store: Store(initialState: MoimScheduleStore.State(), reducer: {
                MoimScheduleStore()
            }))
        }
    }
}

