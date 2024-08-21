//
//  MoimScheduleTemplate.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 4/14/24.
//


import Foundation

/// 모임 일정 생성/수정에 사용되는 모델입니다.
public struct MoimScheduleTemplate {
    /// 모임 ID
	public var moimId: Int?
    /// 일정 ID
	public var moimScheduleId: Int?
    /// 일정 이름
	public var name: String
    /// 시작 날짜-시간
	public var startDate: Date
    /// 종료 날짜-시간
	public var endDate: Date
    /// 경도입니다 : longitude
	public var x: Double
    /// 위도입니다 : latitude
	public var y: Double
    /// 장소 이름
	public var locationName: String
    /// 유저 배열
	public var users: [GroupUser]
    
	public init(
        moimScheduleId: Int? = nil,
        name: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        x: Double? = nil,
        y: Double? = nil,
        locationName: String? = nil,
        users: [GroupUser]? = nil
    ) {
        self.moimScheduleId = moimScheduleId
        self.name = name ?? ""
        self.startDate = startDate ?? Date()
        self.endDate = endDate ?? Date()
        self.x = x ?? 0.0
        self.y = y ?? 0.0
        self.locationName = locationName ?? ""
        self.users = users ?? []
    }
}
