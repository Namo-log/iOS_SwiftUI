//
//  HomeMainView.swift
//  FeatureHome
//
//  Created by 정현우 on 9/18/24.
//

import SwiftUI

import ComposableArchitecture
import SwiftUICalendar

import SharedUtil
import SharedDesignSystem
import FeatureCalendar

public struct HomeMainView: View {
	@Perception.Bindable public var store: StoreOf<HomeMainStore>
	@StateObject var calendarController = CalendarController()
	
	public init(store: StoreOf<HomeMainStore>) {
		self.store = store
	}
	
	public var body: some View {
		VStack(spacing: 0) {
			header
				.padding(.bottom, 22)
				.padding(.horizontal, 20)
			

			NamoCalendarView(
				calendarController: calendarController,
				focusDate: $store.focusDate,
				schedules: $store.schedules,
				dateTapAction: { date in
					store.send(.selectDate(date), animation: .default)
				}
			)

			Spacer()
				.frame(height: tabBarHeight)
			
		}
		.ignoresSafeArea(edges: .bottom)
		.onAppear {
			store.send(.getSchedule(ym: calendarController.yearMonth))
		}
//		.onChange(of: calendarController.yearMonth) { newYM in
//			if calendarController.yearMonth < newYM {
//				// 다음달로
//				store.send(.scrollForwardTo(ym: newYM))
//			} else {
//				// 이전달로
//				store.send(.scrollBackwardTo(ym: newYM))
//			}
//		}
	}
	
	private var header: some View {
		HStack {
			// datepicker
			Button(
				action: {
					store.send(.datePickerTapped)
				}, label: {
					HStack(spacing: 10) {
						Text(calendarController.yearMonth.formatYYYYMM())
							.font(.pretendard(.bold, size: 22))
							.foregroundStyle(Color.colorBlack)
					}
				}
			)
			
			Spacer()
			
			// 보관함
			Button(
				action: {
					store.send(.archiveTapped)
				}, label: {
					Image(asset: SharedDesignSystemAsset.Assets.icArchive)
						.resizable()
						.frame(width: 24, height: 24)
				}
			)
			.padding(.trailing, 20)
			
			// 오늘 날짜로
			Button(
				action: {
					calendarController.scrollTo(.current, isAnimate: true)
				}, label: {
					Text(Date().toDD())
						.font(.pretendard(.semibold, size: 16))
						.background(
							RoundedRectangle(cornerRadius: 5)
								.stroke(.black, lineWidth: 1.5)
								.frame(width: 25, height: 25)
						)
				}
			)
			.tint(Color.colorBlack)
			
		}
	}
}
