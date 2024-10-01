import SwiftUI

import ComposableArchitecture

import FeatureHome

@main
struct FeatureHomeExampleApp: App {
	var body: some Scene {
		WindowGroup {
//			HomeCoordinatorView(
//				store: Store(
//					initialState: HomeCoordinatorStore.State(),
//					reducer: {
//						HomeCoordinatorStore()
//					}
//				)
//			)
			HomeMainView(store: Store(initialState: HomeMainStore.State(), reducer: {
				HomeMainStore()
			}))
		}
	}
}
