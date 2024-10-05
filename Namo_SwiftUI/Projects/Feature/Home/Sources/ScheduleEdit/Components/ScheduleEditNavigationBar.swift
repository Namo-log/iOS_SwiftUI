//
//  ScheduleEditNavigationBar.swift
//  FeatureHome
//
//  Created by 정현우 on 10/3/24.
//

import SwiftUI

struct ScheduleEditNavigationBar<Content: View>: View {
	let title: String
	let leftButton: () -> Content
	let rightButton: (() -> Content)?

	init(
		title: String,
		leftButton: @escaping () -> Content,
		rightButton: (() -> Content)? = nil
	) {
		self.title = title
		self.leftButton = leftButton
		self.rightButton = rightButton
	}

	
	var body: some View {
		HStack {
			leftButton()
			
			Spacer()
			
			Text(title)
			
			Spacer()
			
			if let rightButton = rightButton {
				rightButton()
			}
		}
		.frame(height: 48)
	}
}
