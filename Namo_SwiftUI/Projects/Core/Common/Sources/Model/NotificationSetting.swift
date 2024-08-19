//
//  NotificationSetting.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/25/24.
//

/// 알림 시각 설정을 위한 enum입니다.
public enum NotificationSetting: CaseIterable {
    case none
    case oneHour
    case thirtyMin
    case tenMin
    case fiveMin
    case exactTime
    
	public var toString: String {
        switch self {
        case .none:
            return "없음"
        case .oneHour:
            return "1시간 전"
        case .thirtyMin:
            return "30분 전"
        case .tenMin:
            return "10분 전"
        case .fiveMin:
            return "5분 전"
        case .exactTime:
            return "정시"
        }
    }
    
	public var toInt: Int {
        switch self {
        case .none:
            return -1
        case .oneHour:
            return 60
        case .thirtyMin:
            return 30
        case .tenMin:
            return 10
        case .fiveMin:
            return 5
        case .exactTime:
            return 0
        }
    }
    
	public static func getValueFromInt(_ int: Int) -> NotificationSetting{
        switch int {
        case -1:
            return .none
        case 60:
            return .oneHour
        case 30:
            return .thirtyMin
        case 10:
            return .tenMin
        case 5:
            return .fiveMin
        case 0:
            return .exactTime
        default:
            return .none
        }
    }
}
