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
    let name: String? = nil
    /// 카테고리 ID
    let categoryId: Int? = nil
    /// 시작 날짜-시간
    let startDate: Date? = nil
    /// 종료 날짜-시간
    let endDate: Date? = nil
    /// 알람 설정 시간
    let alarmDate: [Int]? = nil
    /// 위도입니다 : latitude
    let x: Double? = nil
    /// 경도입니다 : longitude
    let y: Double? = nil
    /// 장소 이름
    let locationName: String? = nil
}
