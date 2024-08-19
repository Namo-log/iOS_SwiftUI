//
//  NamoAlertViewWithTitle.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 4/14/24.
//

import SwiftUI
import Factory
import Common

/*
 사용 예시
 NamoAlertViewWithTitle(
	 showAlert: $showWithdrawConfirm,
	 title: "정말 그룹에서 탈퇴하시겠어요?",
	 message: "탈퇴하더라도\n이전 모임 일정은 사라지지 않습니다.",
	 rightButtonTitle: "확인",
	 rightButtonAction: {
		
	 }
 )
 
 24.04.14
 - NamoAlertView를 띄우는 변수를 조절할 때 withAnimation을 감싸주세요
 */

struct NamoAlertViewWithTitle: View {
	
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
					AppState.shared.isTabbarOpaque = false
					showAlert = false
				}
			
			VStack(spacing: 16) {
				VStack(spacing: 8) {
					Text(title)
						.font(.pretendard(.bold, size: 16))
						.foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
						.padding(.top, 24)
					
					if message != nil {
						Text(message!)
							.font(.pretendard(.regular, size: 14))
							.foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
							.multilineTextAlignment(.center)
					}
				}
				
				HStack(spacing: 8) {
					Button(action: leftAction, label: {
						Text("취소")
							.foregroundStyle(Color(asset: CommonAsset.Assets.mainText))
							.frame(width: screenWidth/2 - 50, height: 43)
							.font(.pretendard(.bold, size: 16))
					})
					.background(Color(asset: CommonAsset.Assets.mainGray))
					.cornerRadius(4)
					
					if let rightButtonTitle = rightButtonTitle,
					   let _ = rightButtonAction {
						Button(action: rightAction, label: {
							Text(rightButtonTitle)
								.foregroundStyle(Color.white)
								.frame(width: screenWidth/2 - 50, height: 43)
								.font(.pretendard(.bold, size: 16))
						})
						.background(Color(asset: CommonAsset.Assets.mainOrange))
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
				AppState.shared.isTabbarOpaque = true
			}
		}
    }
	
	private func leftAction() {
		AppState.shared.isTabbarOpaque = false
		showAlert = false
	}
	
	private func rightAction() {
		AppState.shared.isTabbarOpaque = false
		showAlert = false
		rightButtonAction!()
	}
}
