////
////  NamoAlertViewWithOneButton.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 6/2/24.
////
//
//import SwiftUI
//import Factory
//
//import SharedDesignSystem
//import SharedUtil
//
//struct NamoAlertViewWithOneButton: View {
//	
//	@Binding var showAlert: Bool
//	let title: String
//	var message: String? = nil
//	let buttonTitle: String
//	let buttonAction: (() -> Void)
//	
//	var body: some View {
//		ZStack {
//			Color.black.opacity(0.5)
//				.edgesIgnoringSafeArea(.all)
//				.onTapGesture {
//					AppState.shared.isTabbarOpaque = false
//					showAlert = false
//				}
//			
//			VStack(spacing: 16) {
//				VStack(spacing: 8) {
//					Text(title)
//						.font(.pretendard(.bold, size: 16))
//						.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//						.padding(.top, 24)
//					
//					if message != nil {
//						Text(message!)
//							.font(.pretendard(.regular, size: 14))
//							.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//							.multilineTextAlignment(.center)
//					}
//				}
//				
//				Button(action: {
//					AppState.shared.isTabbarOpaque = false
//					showAlert = false
//					buttonAction()
//				}, label: {
//					Text(buttonTitle)
//						.foregroundStyle(Color.white)
//						.frame(width: screenWidth/2 - 50, height: 43)
//						.font(.pretendard(.bold, size: 16))
//						.frame(width: screenWidth - 92)
//				})
//				.background(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
//				.cornerRadius(4)
//				.padding(.bottom, 16)
//				.padding(.horizontal, 16)
//			}
//			.background(Color.white)
//			.frame(width: screenWidth - 60)
//			.cornerRadius(10)
//			.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
//		}
//		.onAppear {
//			withAnimation {
//				AppState.shared.isTabbarOpaque = true
//			}
//		}
//	}
//
//}
