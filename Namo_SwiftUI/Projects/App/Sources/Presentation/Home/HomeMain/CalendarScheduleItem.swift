//
//  CalendarScheduleItem.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/4/24.
//

import SwiftUI

enum CalendarScheduleItemype {
	case onlyOneDay  // 하루 일정
	case startDay  // 여러 일 지속 일정 중 시작일
	case midDay  // 여러 일 지속 일정 중 중간
	case endDay  // 여러 일 지속 일정 중 마지막일
	case startDayWithRightCorner  // 시작일이지만, 주의 마지막으로 오른쪽 코너를 가지는 경우
	case midDayWithRightCorner  // 중간이지만, 주의 마지막으로 오른쪽 코너를 가지는 경우
	case midDayWithLeftCorner  // 중간이지만, 주의 처음으로 왼쪽 코너를 가지는 경우
	case endDayWithLeftCorner  // 마지막날이지만, 주의 처음으로 왼쪽 코너를 가지는 경우
}

// 캘린더에 표시될 한 개의 스케쥴 아이템
struct CalendarScheduleItem: View {
	let calendarScheduleItemype: CalendarScheduleItemype
	let isLargeItem: Bool
	let backgroundColor: Color
	let geometryWidth: CGFloat
	let isFocusYearMonth: Bool
	let scheduleName: String?
	
	var body: some View {
		ZStack(alignment: .leading) {
			Rectangle()
				.fill(backgroundColor)
				.clipShape(RoundedCorners(radius: 3, corners: getCorners(calendarScheduleItemype)))
				.frame(width: getWidth(calendarScheduleItemype, geoWidth: geometryWidth), height: isLargeItem ? 12 : 4)
				.opacity(isFocusYearMonth ? 1 : 0.5)
			
			if let scheduleName = scheduleName, isLargeItem {
				HStack(spacing: 0) {
					Text(scheduleName)
						.lineLimit(1)
						.font(.pretendard(.bold, size: 8))
						.foregroundStyle(Color.white)
						.padding(.leading, 2)
						.padding(.trailing, 6)
					
					Spacer(minLength: 0)
				}
			}
		}
	}
	
	// type에 따른 코너 설정
	func getCorners(_ type: CalendarScheduleItemype) -> UIRectCorner {
		let leftCorners: UIRectCorner = [.topLeft, .bottomLeft]
		let rightCorners: UIRectCorner = [.topRight, .bottomRight]
		
		switch type {
		case .onlyOneDay:
			return .allCorners
		case .startDay:
			return leftCorners
		case .midDay:
			return []
		case .endDay:
			return rightCorners
		case .startDayWithRightCorner:
			return .allCorners
		case .midDayWithRightCorner:
			return rightCorners
		case .midDayWithLeftCorner:
			return leftCorners
		case .endDayWithLeftCorner:
			return .allCorners
		}
	}
	
	// type에 따른 cell Width 설정
	func getWidth(_ type: CalendarScheduleItemype, geoWidth: CGFloat) -> CGFloat {
		let smallWidth = geoWidth - 6
		
		switch type {
		case .onlyOneDay:
			return smallWidth
		case .startDay:
			return geoWidth
		case .midDay:
			return geoWidth
		case .endDay:
			return smallWidth
		case .startDayWithRightCorner:
			return smallWidth
		case .midDayWithRightCorner:
			return smallWidth
		case .midDayWithLeftCorner:
			return geoWidth
		case .endDayWithLeftCorner:
			return smallWidth
		}
	}
}
