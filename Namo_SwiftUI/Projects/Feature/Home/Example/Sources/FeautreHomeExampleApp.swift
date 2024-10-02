import SwiftUI

import ComposableArchitecture

import FeatureHome

@main
struct FeatureHomeExampleApp: App {
	var body: some Scene {
		WindowGroup {
			HomeCoordinatorView(
				store: Store(
					initialState: HomeCoordinator.State.initialState,
					reducer: {
						HomeCoordinator()
					}
				)
			)
		}
	}
}
