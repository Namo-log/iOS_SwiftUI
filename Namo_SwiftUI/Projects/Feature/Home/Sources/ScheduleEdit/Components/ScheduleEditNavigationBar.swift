//
//  ScheduleEditNavigationBar.swift
//  FeatureHome
//
//  Created by 정현우 on 10/3/24.
//

import SwiftUI

struct ScheduleEditNavigationBar<L: View, R: View>: View {
	let title: String
	let leftButton: () -> L
	let rightButton: (() -> R)?

	init(
		title: String,
		leftButton: @escaping () -> L,
		rightButton: (() -> R)? = {EmptyView()}
	) {
		self.title = title
		self.leftButton = leftButton
		self.rightButton = rightButton
	}

	
	var body: some View {
		HStack {
			leftButton()
			
			Spacer()
			
			if let rightButton = rightButton {
				rightButton()
			}
		}
		.overlay {
			Text(title)
				.font(.pretendard(.bold, size: 15))
				.foregroundStyle(Color.colorBlack)
		}
		.frame(height: 48)
	}
}
