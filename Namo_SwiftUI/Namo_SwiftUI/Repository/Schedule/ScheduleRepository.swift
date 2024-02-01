//
//  ScheduleRepository.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

/// 스케줄 관련 데이터를 API 처리하기 위한 Repository 입니다.
/// 게이트웨이
protocol ScheduleRepository {
    
    /// 지정된 ID에 해당하는 스케줄 데이터를 비동기적으로 가져옵니다.
    ///
    /// - Parameters:
    ///     - `id`: 가져올 스케줄의 ID
    /// - Returns: `testGetDeDTO` 타입의 결과 데이터
    func fetchSchedule(id: Int) async -> testGetDeDTO?
    
    /// 주어진 데이터를 사용하여 새로운 스케줄을 서버에 등록하고, 결과를 비동기적으로 반환합니다.
    ///
    /// - Parameters:
    ///     - `data`: 등록할 스케줄 데이터 (`testEnDTO` 타입)
    /// - Returns: `testDeDTO` 타입의 결과 데이터
    func postSchedule(data: testEnDTO) async -> testDeDTO?
    
    /// 서버에서 특정 테스트 데이터를 비동기적으로 가져옵니다.
    ///
    /// - Returns: `testDecodeDTO` 타입의 결과 데이터
    func test() async -> testDecodeDTO?
}
