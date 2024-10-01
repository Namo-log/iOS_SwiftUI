//
//  NamoCalendarView.swift
//  FeatureHome
//
//  Created by 정현우 on 9/27/24.
//

import SwiftUI

import SwiftUICalendar

import SharedDesignSystem

public struct NamoCalendarView: View {
	@ObservedObject var calendarController: CalendarController
	@Binding var focusDate: YearMonthDay?
	let dateTapAction: (YearMonthDay) -> Void
	
	public var body: some View {
		GeometryReader { reader in
			VStack {
				CalendarView(calendarController) { date in
					GeometryReader { geometry in
						VStack(alignment: .leading) {
							calendarDate(date: date)
								.onTapGesture {
									dateTapAction(date)
								}
						}
						.frame(width: geometry.size.width, height: geometry.size.height, alignment: .topLeading)
					}
				}
			}
		}
	}
	
	private func calendarDate(date: YearMonthDay) -> some View {
		GeometryReader { geometry in
			if date.isToday {
				Text("\(date.day)")
					.font(.pretendard(.bold, size: 12))
					.foregroundStyle(Color.white)
					.background(
						Circle()
							.fill(
								(date.isFocusYearMonth ?? false)
								? Color(asset: SharedDesignSystemAsset.Assets.mainOrange)
								: Color(asset: SharedDesignSystemAsset.Assets.mainOrange).opacity(0.5))
							.frame(width: 18, height: 18)
					)
			} else {
				Text("\(date.day)")
					.font(.pretendard(.bold, size: 12))
					.foregroundStyle(
						focusDate == date
						? Color(asset: SharedDesignSystemAsset.Assets.mainOrange)
						: (date.isFocusYearMonth ?? true)
							? Color.black
							: Color(asset: SharedDesignSystemAsset.Assets.textUnselected)
					)
			}
		}
	}
}
