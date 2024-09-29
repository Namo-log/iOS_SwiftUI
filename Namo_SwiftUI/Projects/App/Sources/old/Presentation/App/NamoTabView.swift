//
//  NamoTabView.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 1/19/24.
//

import SwiftUI

import SharedDesignSystem
import SharedUtil

struct NamoTabView: View {
	@Binding var currentTab: Tab
	
	var body: some View {
		VStack(spacing: 0) {
			HStack {
				Image(asset: currentTab == .home ? SharedDesignSystemAsset.Assets.icBottomHomeSelect : SharedDesignSystemAsset.Assets.icBottomHomeNoSelect)
					.onTapGesture {
						currentTab = .home
					}
				
				Spacer()
				
				Image(asset: currentTab == .diary ? SharedDesignSystemAsset.Assets.icBottomDiarySelect : SharedDesignSystemAsset.Assets.icBottomDiaryNoSelect)
					.onTapGesture {
						currentTab = .diary
					}
				
				Spacer()
				
				Image(asset: currentTab == .group ? SharedDesignSystemAsset.Assets.icBottomShareSelect : SharedDesignSystemAsset.Assets.icBottomShareNoSelect)
					.onTapGesture {
						currentTab = .group
					}
				
				Spacer()
				
				Image(asset: currentTab == .custom ? SharedDesignSystemAsset.Assets.icBottomCustomSelect : SharedDesignSystemAsset.Assets.icBottomCustomNoSelect)
					.onTapGesture {
						currentTab = .custom
					}
			}
			
			Spacer(minLength: 0)
		}
		.padding(.horizontal, 30)
		.padding(.top, 13)
		.frame(width: screenWidth, height: tabBarHeight)
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
