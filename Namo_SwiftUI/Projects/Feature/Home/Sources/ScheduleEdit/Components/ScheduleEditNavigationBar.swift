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
	let rightButton: () -> Content

	
	var body: some View {
		HStack {
			leftButton()
			
			Spacer()
			
			Text(title)
			
			Spacer()
			
			rightButton()
		}
		.frame(height: 48)
	}
}
