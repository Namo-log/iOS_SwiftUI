////
////  AlertViewWithContent.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 6/27/24.
////
//
//import SwiftUI
//
//import SharedDesignSystem
//import SharedUtil
//
//struct AlertViewWithContent: View {
//	@Binding var showAlert: AlertType?
//	let content: AnyView
//	var leftButtonTitle: String?
//	var leftButtonAction: () -> Void = {}
//	let rightButtonTitle: String
//	let rightButtonAction: () -> Void
//	
//    var body: some View {
//		ZStack {
////			Color.black.opacity(0.5)
////				.edgesIgnoringSafeArea(.all)
////				.onTapGesture {
////					showAlert = nil
////				}
//			
//			VStack(spacing: 16) {
//				content
//					.padding(.horizontal, 16)
//				
//				HStack(spacing: 8) {
//					if let leftButtonTitle = leftButtonTitle {
//						Button(action: leftButtonAction, label: {
//							Text(leftButtonTitle)
//								.foregroundStyle(Color(asset: SharedDesignSystemAsset.Assets.mainText))
//								.frame(width: screenWidth/2 - 50, height: 43)
//								.font(.pretendard(.bold, size: 16))
//						})
//						.background(Color(asset: SharedDesignSystemAsset.Assets.mainGray))
//						.cornerRadius(4)
//					}
//					
//					
//					Button(action: rightButtonAction, label: {
//						Text(rightButtonTitle)
//							.foregroundStyle(Color.white)
//							.frame(width: screenWidth/2 - 50, height: 43)
//							.font(.pretendard(.bold, size: 16))
//					})
//					.background(Color(asset: SharedDesignSystemAsset.Assets.mainOrange))
//					.cornerRadius(4)
//				}
//				.padding(.bottom, 16)
//				.padding(.horizontal, 16)
//			}
//			.background(Color.white)
//			.frame(width: screenWidth - 60)
//			.cornerRadius(10)
//			.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
//		}
//    }
//}
