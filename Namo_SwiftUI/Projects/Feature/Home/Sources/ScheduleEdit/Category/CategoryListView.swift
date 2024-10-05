//
//  CategoryListView.swift
//  FeatureHome
//
//  Created by 정현우 on 10/5/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

struct CategoryListView: View {
	let store: StoreOf<CategoryListStore>
	
	var body: some View {
		VStack {
			navigationBar
			
			ScrollView(.vertical, showsIndicators: false) {
				categoryList
			}
		}
		.toolbar(.hidden, for: .navigationBar)
	}
	
	private var navigationBar: some View {
		ScheduleEditNavigationBar(
			title: "카테고리",
			leftButton: {
				Button(
					action: {
						store.send(.backBtnTapped)
					},
					label: {
						HStack {
							Image(asset: SharedDesignSystemAsset.Assets.icLeft)
							
							Text("일정")
								.font(.pretendard(.regular, size: 15))
						}
					}
				)
				.tint(Color.mainText)
			}
		)
	}
	
	private var categoryList: some View {
		VStack {
			ForEach(store.categories, id: \.categoryId) { category in
				HStack {
					Button(
						action: {
							store.send(.categorySelect(category))
						},
						label: {
							ColorCircleView(
								color: Color.paletteColor(id: category.colorId),
								isChecked: category.categoryId == store.schedule.category.categoryId
							)
							.frame(width: 20, height: 20)
						}
					)
					
					Button(
						action: {
							store.send(.categorySelect(category))
						},
						label: {
							HStack {
								Text(category.categoryName)
									.font(.pretendard(.regular, size: 15))
									.foregroundStyle(Color.mainText)
								
								Image(asset: SharedDesignSystemAsset.Assets.icRight)
								
								Spacer()
							}
						}
					)
				}
				
			}
			
			Button(
				action: {
					store.send(.newCategoryTapped)
				},
				label: {
					HStack {
						Image(asset: SharedDesignSystemAsset.Assets.icAdded)
						Text("새 카테고리 추가")
					}
				}
			)
		}
	}
}
