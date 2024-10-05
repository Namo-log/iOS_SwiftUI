//
//  CategoryEditView.swift
//  FeatureHome
//
//  Created by 정현우 on 10/5/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

struct CategoryEditView: View {
	let store: StoreOf<CategoryEditStore>
	
	var body: some View {
		ZStack(alignment: .top) {
			if !store.isNewCategory {
				DeleteCircleButton(action: {
					
				})
			}
			
			VStack {
				navigationBar
			}
		}
		.toolbar(.hidden, for: .navigationBar)
	}
	
	private var navigationBar: some View {
		ScheduleEditNavigationBar(
			title: store.isNewCategory ? "새 카테고리" : "카테고리 편집",
			leftButton: {
				Button(
					action: {
						store.send(.backBtnTapped)
					},
					label: {
						HStack {
							Image(asset: SharedDesignSystemAsset.Assets.icLeft)
							
							Text("카테고리")
								.font(.pretendard(.regular, size: 15))
						}
					}
				)
				.tint(Color.mainText)
			}
		)
	}
}
