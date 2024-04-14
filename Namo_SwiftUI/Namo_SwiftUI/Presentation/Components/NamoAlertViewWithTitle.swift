//
//  NamoAlertViewWithTitle.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 4/14/24.
//

import SwiftUI
import Factory

struct NamoAlertViewWithTitle: View {
	@Injected(\.appState) var appState
	
	@Binding var showAlert: Bool
	let title: String
	var message: String? = nil
	var rightButtonTitle: String? = nil
	var rightButtonAction: (() -> Void)? = {}
	
    var body: some View {
		ZStack {
			Color.black.opacity(0.5)
				.edgesIgnoringSafeArea(.all)
				.onTapGesture {
					appState.isTabbarOpaque = false
					showAlert = false
				}
			
			VStack(spacing: 16) {
				VStack(spacing: 8) {
					Text(title)
						.font(.pretendard(.bold, size: 16))
						.foregroundStyle(Color.mainText)
						.padding(.top, 24)
					
					if message != nil {
						Text(message!)
							.font(.pretendard(.regular, size: 14))
							.foregroundStyle(Color.mainText)
							.multilineTextAlignment(.center)
					}
				}
				
				HStack(spacing: 8) {
					Button(action: leftAction, label: {
						Text("취소")
							.foregroundStyle(Color(.mainText))
							.frame(width: screenWidth/2 - 50, height: 43)
							.font(.pretendard(.bold, size: 16))
					})
					.background(Color(.mainGray))
					.cornerRadius(4)
					
					if let rightButtonTitle = rightButtonTitle,
					   let _ = rightButtonAction {
						Button(action: rightAction, label: {
							Text(rightButtonTitle)
								.foregroundStyle(Color.white)
								.frame(width: screenWidth/2 - 50, height: 43)
								.font(.pretendard(.bold, size: 16))
						})
						.background(Color(.mainOrange))
						.cornerRadius(4)
					}
				}
				.padding(.bottom, 16)
				.padding(.horizontal, 16)
			}
			.background(Color.white)
			.frame(width: screenWidth - 60)
			.cornerRadius(10)
			.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
			
			
		}
		.onAppear {
			withAnimation {
				appState.isTabbarOpaque = true
			}
		}
    }
	
	private func leftAction() {
		appState.isTabbarOpaque = false
		showAlert = false
	}
	
	private func rightAction() {
		appState.isTabbarOpaque = false
		showAlert = false
		rightButtonAction!()
	}
}
