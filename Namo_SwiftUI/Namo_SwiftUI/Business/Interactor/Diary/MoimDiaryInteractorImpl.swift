//
//  MoimDiaryInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Factory
import SwiftUI

/// 모임 기록 API
struct MoimDiaryInteractorImpl: MoimDiaryInteractor {
    @Injected(\.appState) private var appState
    @Injected(\.diaryState) private var diaryState
    @Injected(\.moimDiaryRepository) var moimDiaryRepository
    
    /// 모임 메모 장소 생성
    func createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool {
        print("모임 기록 생성 요청")
        return await moimDiaryRepository.createMoimDiaryPlace(moimScheduleId: moimScheduleId, req: req)
    }
    
    /// 모임 메모 장소 수정
    func changeMoimDiaryPlace(moimLocationId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool {
        return await moimDiaryRepository.changeMoimDiaryPlace(moimLocationId: moimLocationId, req: req)
    }
    
    /// 모임 메모 장소 삭제
    func deleteMoimDiaryPlace(moimLocationId: Int) async -> Bool {
        return await moimDiaryRepository.deleteMoimDiaryPlace(moimLocationId: moimLocationId)
    }
    
    /// 모임 기록에 대한 개인 메모 추가/수정
    func editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO) async -> Bool {
        return await moimDiaryRepository.editMoimDiary(scheduleId: scheduleId, req: req)
    }
    
    /// 모임 메모 삭제
    func deleteMoimDiary(moimMemoId: Int) async -> Bool {
        return await moimDiaryRepository.deleteMoimDiary(moimMemoId: moimMemoId)
    }
    
    /// 월간 모임 메모 조회
    func getMonthMoimDiary(req: GetMonthMoimDiaryReqDTO) async {
        var diaries = await moimDiaryRepository.getMonthMoimDiary(req: req)?.content ?? []
        print("월간 모임 기록 조회")
        print(diaries)
        DispatchQueue.main.async {
            if req.page == 0 {
                diaryState.monthDiaries = diaries
            } else {
                diaryState.monthDiaries += diaries
            }
        }
    }
    
    /// 단건 모임 메모 조회
    func getOneMoimDiary(moimScheduleId: Int) async {
        guard let res = await moimDiaryRepository.getOneMoimDiary(moimScheduleId: moimScheduleId) else { return }
        DispatchQueue.main.async {
            diaryState.currentMoimDiaryInfo = res
        }
    }
}
