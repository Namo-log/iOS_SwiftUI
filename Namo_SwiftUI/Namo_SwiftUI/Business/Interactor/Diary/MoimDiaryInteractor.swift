//
//  MoimDiaryInteractor.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Foundation

/// 모임 기록 API
protocol MoimDiaryInteractor {
    func createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool
    func changeMoimDiaryPlace(activityId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool
    func deleteMoimDiaryPlace(activityId: Int) async -> Bool
    @discardableResult func editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO) async -> Bool
    @discardableResult func deleteMoimDiary(moimScheduleId: Int) async -> Bool
    func getMonthMoimDiary(req: GetMonthMoimDiaryReqDTO) async
    func getOneMoimDiary(moimScheduleId: Int ) async
    func getOneMoimDiaryDetail(moimScheduleId: Int ) async
}
