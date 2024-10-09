//
//  ReminderSettingView.swift
//  FeatureHome
//
//  Created by 정현우 on 10/6/24.
//

import SwiftUI

import ComposableArchitecture

import SharedDesignSystem

struct ReminderSettingView: View {
	@Perception.Bindable var store: StoreOf<ReminderSettingStore>
	
	var body: some View {
		WithPerceptionTracking {
			VStack(spacing: 0) {
				navigationBar
					.padding(.horizontal, 19)
					.padding(.bottom, 16)
				
				ScrollView(.vertical, showsIndicators: false) {
					reminders
						.padding(.bottom, 16)
					
					addReminder
				}
				.frame(maxWidth: .infinity)
				.padding(.top, 12)
				.padding(.horizontal, 30)
			}
			.toolbar(.hidden, for: .navigationBar)
		}
	}
	
	private var navigationBar: some View {
		ScheduleEditNavigationBar(
			title: "알림 설정",
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
			},
			rightButton: {
				Button(
					action: {
						store.send(.saveReminderBtnTapped)
					},
					label: {
						Text("저장")
							.font(.pretendard(.regular, size: 15))
					}
				)
				.tint(Color.mainText)
			}
		)
	}
	
	private var reminders: some View {
		VStack(spacing: 16) {
			radioItem(
				name: "없음",
				action: {
					store.send(.noReminderTapped)
				}
			)
			
			Divider()
				.foregroundStyle(Color.textUnselected)
				.frame(height: 1)
			
			ForEach(store.timeList, id: \.self) { time in
				radioItem(
					name: time,
					action: {
						store.send(.timeReminderTapped(time))
					}
				)
			}
		}
	}
	
	private var addReminder: some View {
		VStack(spacing: 16) {
			HStack {
				Button(
					action: {
						store.send(.toggleAddReminder, animation: .default)
					},
					label: {
						HStack {
							Image(
								asset:
									store.showAddReminder ?
								SharedDesignSystemAsset.Assets.icUp :
									SharedDesignSystemAsset.Assets.icDown
							)
							
							Text("직접 설정하기")
								.font(.pretendard(.regular, size: 15))
						}
					}
				)
				.tint(Color.mainText)
				
				Spacer()
			}
			
			if store.showAddReminder {
				HStack(spacing: 0) {
					Picker("", selection: $store.selectedTime) {
						ForEach(store.pickerTimeList, id: \.self) { time in
							Text("\(time)")
						}
					}
					.pickerStyle(.wheel)
					
					Picker("", selection: $store.selectedUnit) {
						ForEach(["분", "시간", "일"], id: \.self) { unit in
							Text("\(unit)")
						}
					}
					.pickerStyle(.wheel)
					
					Divider()
						.foregroundStyle(Color.textUnselected)
						.frame(width: 1)
						.padding(.vertical, 12)
					
					Button(
						action: {
							store.send(.addReminder)
						},
						label: {
							VStack(spacing: 12) {
								Image(asset: SharedDesignSystemAsset.Assets.icAdded)
								Text("추가")
									.font(.pretendard(.regular, size: 15))
							}
						}
					)
					.tint(Color.mainText)
					.padding(.horizontal, 30)
				}
				.frame(height: 128)
				.background {
					RoundedRectangle(cornerRadius: 10)
						.fill(Color.itemBackground)
				}
			}
		}
	}
	
	private func radioItem(
		name: String,
		action: @escaping () -> Void
	) -> some View {
		HStack(spacing: 0) {
			Button(
				action: {
					action()
				},
				label: {
					HStack(spacing: 16) {
						if name == "없음" {
							Image(asset:
									store.selectedTimeList.isEmpty ?
								  SharedDesignSystemAsset.Assets.icRatioCircleSelected :
									SharedDesignSystemAsset.Assets.icRatioCircle
							)
						} else {
							Image(asset:
									store.selectedTimeList.contains(name) ?
								  SharedDesignSystemAsset.Assets.icRatioCircleSelected :
									SharedDesignSystemAsset.Assets.icRatioCircle
							)
						}
						
						Text(name)
							.font(.pretendard(.regular, size: 15))
					}
				}
			)
			.tint(Color.mainText)
			
			
			if (!["없음", "정시", "5분 전", "10분 전", "30분 전", "1시간 전"].contains(name)) {
				Button(
					action: {
						store.send(.removeReminder(name))
					},
					label: {
						Image(asset: SharedDesignSystemAsset.Assets.icXmark)
							.padding(.horizontal, 8)
					}
				)
				
			}
			
			Spacer()
		}
	}
}
