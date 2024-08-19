//
//  AlertViewWithTopButton.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 6/27/24.
//

import SwiftUI
import Common

struct AlertViewWithTopButton: View {
	@Binding var showAlert: AlertType?
	let title: String
	let leftButtonTitle: String
	let leftButtonAction: () -> Void
	let rightButtonTitle: String
	let rightButtonAction: () -> Void
	let content: AnyView
	
	var body: some View {
		ZStack {
			Color.black.opacity(0.5)
				.edgesIgnoringSafeArea(.all)
				.onTapGesture {
					showAlert = nil
				}
			
			VStack(spacing: 0) {
				HStack {
					Button(action: leftButtonAction, label: {
						Text(leftButtonTitle)
							.font(.pretendard(.regular, size: 15))
					})
					.tint(Color(asset: CommonAsset.Assets.mainText))
					
					Spacer()
					
					Text(title)
						.font(.pretendard(.bold, size: 15))
					
					Spacer()
					
					Button(action: rightButtonAction, label: {
						Text(rightButtonTitle)
							.font(.pretendard(.regular, size: 15))
					})
					.tint(Color(asset: CommonAsset.Assets.mainText))
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
	}
}
