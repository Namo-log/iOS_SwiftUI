//
//  ScheduleTemplate.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/18/24.
//

import Foundation

/// 일정 생성에 사용되는 모델입니다.
struct ScheduleTemplate {
    /// 일정 이름
    var name: String
    /// 카테고리 ID
    var categoryId: Int
    /// 시작 날짜-시간
    var startDate: Date
    /// 종료 날짜-시간
    var endDate: Date
    /// 알람 설정 시간
    var alarmDate: [Int]
    /// 경도입니다 : longitude
    var x: Double
    /// 위도입니다 : latitude
    var y: Double
    /// 장소 이름
    var locationName: String
}
