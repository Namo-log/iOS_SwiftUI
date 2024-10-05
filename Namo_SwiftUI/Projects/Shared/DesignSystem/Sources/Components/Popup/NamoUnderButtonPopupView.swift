//
//  NamoUnderButtonPopupView.swift
//  SharedDesignSystem
//
//  Created by 정현우 on 10/2/24.
//

import SwiftUI

public struct NamoUnderButtonPopupModifier<CotentView: View>: ViewModifier {
	@Binding private var isPresented: Bool
	
	private let contentView: () -> CotentView
	private let confirmAction: (() -> Void)
	
	public init(
		isPresented: Binding<Bool>,
		contentView: @escaping () -> CotentView,
		confirmAction: @escaping (() -> Void)
	) {
		self._isPresented = isPresented
		self.contentView = contentView
		self.confirmAction = confirmAction
	}
	
	public func body(content: Content) -> some View {
		content
			.overlay {
				if isPresented {
					ZStack {
						Color.black.opacity(0.5)
							.ignoresSafeArea(.all)
							.onTapGesture {
								isPresented = false
							}
						
						
						VStack(spacing: 16) {
							contentView()
								.padding(.horizontal, 16)
							
							HStack(spacing: 8) {
								Button(
									action: {
										isPresented = false
									},
									label: {
										Text("닫기")
											.foregroundStyle(Color.mainText)
											.frame(height: 43)
											.frame(maxWidth: .infinity)
											.font(.pretendard(.bold, size: 16))
									}
								)
								.background(Color.mainGray)
								.cornerRadius(4)
								
								
								Button(
									action: confirmAction,
									label: {
										Text("확인")
											.foregroundStyle(Color.white)
											.frame(height: 43)
											.frame(maxWidth: .infinity)
											.font(.pretendard(.bold, size: 16))
									}
								)
								.background(Color.mainOrange)
								.cornerRadius(4)
							}
							.padding(.bottom, 16)
							.padding(.horizontal, 16)
						}
						.frame(maxWidth: .infinity)
						.background(.white)
						.cornerRadius(10)
						.shadow(color: .black.opacity(0.25), radius: 5, x: 0, y: 0)
						.padding(.horizontal, 30)
					}
					.frame(
						width: UIScreen.main.bounds.width,
						height: UIScreen.main.bounds.height
					)
				}
			}
	}
}

extension View {
	public func namoUnderButtonPopupView<Content: View>(
		isPresented: Binding<Bool>,
		contentView: @escaping () -> Content,
		confirmAction: @escaping (() -> Void)
	) -> some View {
		modifier(
			NamoUnderButtonPopupModifier(
				isPresented: isPresented,
				contentView: contentView,
				confirmAction: confirmAction
			)
		)
	}
}
