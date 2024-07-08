//
//  MoimScheduleTemplate.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 4/14/24.
//


import Foundation

/// 모임 일정 생성/수정에 사용되는 모델입니다.
struct MoimScheduleTemplate {
    /// 모임 ID
    var moimId: Int?
    /// 일정 ID
    var moimScheduleId: Int?
    /// 일정 이름
    var name: String
    /// 시작 날짜-시간
    var startDate: Date
    /// 종료 날짜-시간
    var endDate: Date
    /// 경도입니다 : longitude
    var x: Double
    /// 위도입니다 : latitude
    var y: Double
    /// 장소 이름
    var locationName: String
    /// 유저 배열
    var users: [MoimUser]
    
    init(
        moimScheduleId: Int? = nil,
        name: String? = nil,
        startDate: Date? = nil,
        endDate: Date? = nil,
        x: Double? = nil,
        y: Double? = nil,
        locationName: String? = nil,
        users: [MoimUser]? = nil
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
