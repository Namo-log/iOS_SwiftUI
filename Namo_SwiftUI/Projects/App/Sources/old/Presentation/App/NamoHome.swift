////
////  NamoHome.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 1/18/24.
////
//
//import SwiftUI
//import Factory
//
//enum Tab {
//	case home
//	case diary
//	case group
//	case custom
//}
//
//struct NamoHome: View {
//	@EnvironmentObject var appState: AppState
//	
//	var body: some View {
//		NavigationStack(path: $appState.navigationPath) {
//			ZStack(alignment: .bottom) {
//				VStack(spacing: 0) {
//					Spacer(minLength: 0)
//					
//                    switch appState.currentTab {
//					case .home:
//						HomeMainView()
//					case .diary:
//						DiaryMainView()
//					case .group:
//						GroupMainView()
//					case .custom:
//						CustomMainView()
//					}
//					
//					Spacer(minLength: 0)
//				}
//				
//                NamoTabView(currentTab: $appState.currentTab)
//					.hidden(appState.isTabbarHidden)
//					.overlay {
//						if appState.isTabbarOpaque && !appState.isTabbarHidden {
//							Color.black.opacity(0.5)
//						}
//					}
//				
//				if appState.alertType != nil {
//					NamoAlertView()
//				}
//
//			}
//			.ignoresSafeArea(edges: .bottom)
//		}
//	}
//}
//
//#Preview {
//    NamoHome()
//}
//
