//
//  NamoTabView.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/19/24.
//

import SwiftUI

struct NamoTabView: View {
	@Binding var currentTab: Tab
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Image(currentTab == .home ? .icBottomHomeSelect : .icBottomHomeNoSelect)
					.onTapGesture {
						currentTab = .home
					}
				
				Spacer()
				
				Image(currentTab == .diary ? .icBottomDiarySelect : .icBottomDiaryNoSelect)
					.onTapGesture {
						currentTab = .diary
					}
				
				Spacer()
				
				Image(currentTab == .group ? .icBottomShareSelect : .icBottomShareNoSelect)
					.onTapGesture {
						currentTab = .group
					}
				
				Spacer()
				
				Image(currentTab == .custom ? .icBottomCustomSelect : .icBottomCustomNoSelect)
					.onTapGesture {
						currentTab = .custom
					}
			}
			
			Spacer(minLength: 0)
		}
		.padding(.horizontal, 30)
		.padding(.top, 13)
		.frame(width: screenWidth, height: 80)
		.background(
			Rectangle()
				.fill(Color.white)
				.shadow(color: .black.opacity(0.15), radius: 6, x: 0, y: 0)
		)
	}
}

#Preview {
	NamoTabView(currentTab: .constant(.home))
}
