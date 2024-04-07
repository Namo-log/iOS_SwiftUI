//
//  NamoHome.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/18/24.
//

import SwiftUI
import Factory

enum Tab {
	case home
	case diary
	case group
	case custom
}

struct NamoHome: View {
	@EnvironmentObject var appState: AppState
	@Injected(\.scheduleInteractor) var scheduleInteractor
//	@State var currentTab: Tab = .home
	
	var body: some View {
		NavigationStack {
			ZStack(alignment: .bottom) {
				VStack(spacing: 0) {
					Spacer(minLength: 0)
					
                    switch appState.currentTab {
					case .home:
						HomeMainView()
					case .diary:
						DiaryMainView()
					case .group:
						GroupMainView()
					case .custom:
						CustomMainView()
					}
					
					Spacer(minLength: 0)
				}
				
                NamoTabView(currentTab: $appState.currentTab)
					.hidden(appState.isTabbarHidden)
					.overlay {
						if appState.isTabbarOpaque && !appState.isTabbarHidden {
							Color.black.opacity(0.5)
						}
					}

			}
			.ignoresSafeArea(edges: .bottom)
			.task {
				await scheduleInteractor.setCalendar(date: Date())
			}
		}
	}
}

#Preview {
    NamoHome()
}

