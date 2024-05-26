//
//  MoimDiaryRepository.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Foundation

/// 모임 기록 API
protocol MoimDiaryRepository {
    func createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool
    func changeMoimDiaryPlace(moimLocationId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool
    func deleteMoimDiaryPlace(moimLocationId: Int) async -> Bool
    func editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO) async -> Bool
    func deleteMoimDiary(moimMemoId: Int) async -> Bool
    func getMonthMoimDiary(req: GetMonthMoimDiaryReqDTO) async -> GetMonthMoimDiaryResDTO?
    func getOneMoimDiary(moimScheduleId: Int) async -> GetOneMoimDiaryResDTO?
    func getOneMoimDiaryDetail(moimScheduleId: Int) async -> Diary?
}
