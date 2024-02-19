//
//  NamoAlertViewWithTopButton.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

import SwiftUI
import Factory

/*
 사용 예시
 NamoAlertViewWithTopButton(
	 showAlert: $showNewGroupAlert,
	 title: "새 그룹",
	 leftButtonTitle: "닫기",
	 leftButtonAction: {},
	 rightButtonTitle: "완료",
	 rightButtonAction: {},
	 content: AnyView(
		 VStack(spacing: 0) {
 
		}
	 )
 )
 
 */

struct NamoAlertViewWithTopButton: View {
	@Injected(\.appState) var appState
	
	@Binding var showAlert: Bool
	let title: String
	let leftButtonTitle: String
	let leftButtonAction: () -> Void
	let rightButtonTitle: String
	let rightButtonAction: () async -> Void
	let content: AnyView
	
    var body: some View {
		ZStack {
			Color.black.opacity(0.5)
				.edgesIgnoringSafeArea(.all)
				.onTapGesture {
					appState.isTabbarOpaque = false
					showAlert = false
				}
			
			VStack(spacing: 0) {
				HStack {
					Button(action: leftAction, label: {
						Text(leftButtonTitle)
							.font(.pretendard(.regular, size: 15))
					})
					.tint(.mainText)
					
					Spacer()
					
					Text(title)
						.font(.pretendard(.bold, size: 15))
					
					Spacer()
					
					Button(action: {
						Task {
							await rightAction()
						}
					}, label: {
						Text(rightButtonTitle)
							.font(.pretendard(.regular, size: 15))
					})
					.tint(.mainText)
				}
				.padding(.top, 15)
				.padding(.horizontal, 20)
				
				content
					.padding(.horizontal, 30)
				
			}
			.background(Color.white)
			.frame(width: screenWidth - 60)
			.cornerRadius(10)
			.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
		}
		.onAppear {
			appState.isTabbarOpaque = true
		}
    }
	
	private func leftAction() {
		appState.isTabbarOpaque = false
		showAlert = false
		leftButtonAction()
	}
	
	private func rightAction() async {
		DispatchQueue.main.async {
			self.appState.isTabbarOpaque = false
			self.showAlert = false
		}
		await rightButtonAction()
	}
}
