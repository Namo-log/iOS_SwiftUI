//
//  NamoAlertView.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/9/24.
//

import SwiftUI
import Factory

/*
 사용 예시
 NamoAlertView(
	 showAlert: $showDatePicker,
	 content: AnyView(
		 HStack(spacing: 0) {
 
		 }
	 ),
	 leftButtonTitle: "취소",
	 leftButtonAction: {
		 
	 },
	 rightButtonTitle: "확인",
	 rightButtonAction: {
		 
	 }
 )
 
 24.03.05
 - NamoAlertView를 띄우는 변수를 조절할 때 withAnimation을 감싸주세요
 */

struct AlertViewOld: View {
	
	@Binding var showAlert: Bool
	let content: AnyView
	var leftButtonTitle: String?
	var leftButtonAction: () -> Void = {}
	let rightButtonTitle: String
	let rightButtonAction: () -> Void
	
    var body: some View {
		ZStack {
			Color.black.opacity(0.5)
				.edgesIgnoringSafeArea(.all)
				.onTapGesture {
					AppState.shared.isTabbarOpaque = false
					showAlert = false
				}
			
			VStack(spacing: 16) {
				content
					.padding(.horizontal, 16)
				
				HStack(spacing: 8) {
					if let leftButtonTitle = leftButtonTitle {
						Button(action: leftButtonAction, label: {
							Text(leftButtonTitle)
								.foregroundStyle(Color(.mainText))
								.frame(width: screenWidth/2 - 50, height: 43)
								.font(.pretendard(.bold, size: 16))
						})
						.background(Color(.mainGray))
						.cornerRadius(4)
					}
					
					
					Button(action: rightButtonAction, label: {
						Text(rightButtonTitle)
							.foregroundStyle(Color.white)
							.frame(width: screenWidth/2 - 50, height: 43)
							.font(.pretendard(.bold, size: 16))
					})
					.background(Color(.mainOrange))
					.cornerRadius(4)
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
				AppState.shared.isTabbarOpaque = true
			}
		}
    }
}
