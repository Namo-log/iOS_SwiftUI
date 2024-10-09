//
//  ScheduleMapper.swift
//  DomainSchedule
//
//  Created by 정현우 on 9/18/24.
//

import Foundation

import CoreNetwork

// MARK: - toEntity()
extension ScheduleDTO {
	func toEntity() -> Schedule {
		return Schedule(
			scheduleId: scheduleId,
			title: title,
			categoryInfo: categoryInfo.toEntity(),
			startDate: Date(timeIntervalSince1970: TimeInterval(startDate)),
			endDate: Date(timeIntervalSince1970: TimeInterval(endDate)),
			interval: interval,
			locationInfo: locationInfo.toEntity(),
			hasDiary: hasDiary,
			isMeetingSchedule: isMeetingSchedule,
			meetingInfo: meetingInfo?.toEntity(),
			notificationInfo: notificationInfo.map { $0.toEntity() }
		)
	}
}

extension ScheduleCategoryDTO {
	func toEntity() -> ScheduleCategory {
		return ScheduleCategory(
			categoryId: categoryId,
			colorId: colorId,
			name: name,
			isShared: isShared
		)
	}
}

extension ScheduleLocationDTO {
	func toEntity() -> ScheduleLocation {
		return ScheduleLocation(
			longitude: longitude,
			latitude: latitude,
			locationName: locationName,
			kakaoLocationId: kakaoLocationId
		)
	}
}

extension ScheduleMeetingDTO {
	func toEntity() -> ScheduleMeeting {
		return ScheduleMeeting(
			participantCount: participantCount,
			participantNicknames: participantNicknames,
			isOwner: isOwner
		)
	}
}

extension ScheduleNotificationDTO {
	func toEntity() -> ScheduleNotification {
		return ScheduleNotification(
			notificationId: notificationId,
			trigger: trigger
		)
	}
}

// MARK: - toData()
extension Schedule {
	func toData() -> ScheduleDTO {
		return ScheduleDTO(
			scheduleId: scheduleId,
			title: title,
			categoryInfo: categoryInfo.toData(),
			startDate: Int(startDate.timeIntervalSince1970),
			endDate: Int(endDate.timeIntervalSince1970),
			interval: interval,
			locationInfo: locationInfo.toData(),
			hasDiary: hasDiary,
			isMeetingSchedule: isMeetingSchedule,
			meetingInfo: meetingInfo?.toData(),
			notificationInfo: notificationInfo.map { $0.toData() }
		)
	}
}

extension ScheduleCategory {
	func toData() -> ScheduleCategoryDTO {
		return ScheduleCategoryDTO(
			categoryId: categoryId,
			colorId: colorId,
			name: name,
			isShared: isShared
		)
	}
}

extension ScheduleLocation {
	func toData() -> ScheduleLocationDTO {
		return ScheduleLocationDTO(
			longitude: longitude,
			latitude: latitude,
			locationName: locationName,
			kakaoLocationId: kakaoLocationId
		)
	}
}

extension ScheduleMeeting {
	func toData() -> ScheduleMeetingDTO {
		return ScheduleMeetingDTO(
			participantCount: participantCount,
			participantNicknames: participantNicknames,
			isOwner: isOwner
		)
	}
}

extension ScheduleNotification {
	func toData() -> ScheduleNotificationDTO {
		return ScheduleNotificationDTO(
			notificationId: notificationId,
			trigger: trigger
		)
	}
}
