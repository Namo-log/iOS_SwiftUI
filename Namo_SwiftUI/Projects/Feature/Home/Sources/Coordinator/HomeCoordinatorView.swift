//
//  HomeCoordinatorView.swift
//  FeatureHome
//
//  Created by 정현우 on 9/27/24.
//

import SwiftUI

import ComposableArchitecture
import TCACoordinators

public struct HomeCoordinatorView: View {
	let store: StoreOf<HomeCoordinatorStore>
	
	public var body: some View {
		TCARouter(store.scope(state: \.routes, action: \.router)) { screen in
			switch screen.case {
			case let .homeMain(store):
				HomeMainView(store: store)
			}
		}
	}
}
