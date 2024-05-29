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
        print("모임 기록 생성 요청 \(req)")
        return await moimDiaryRepository.createMoimDiaryPlace(moimScheduleId: moimScheduleId, req: req)
    }
    
    /// 모임 메모 장소 수정
    func changeMoimDiaryPlace(activityId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool {
        return await moimDiaryRepository.changeMoimDiaryPlace(activityId: activityId, req: req)
    }
    
    /// 모임 메모 장소 삭제
    func deleteMoimDiaryPlace(activityId: Int) async -> Bool {
        if await moimDiaryRepository.deleteMoimDiaryPlace(activityId: activityId) {
            DispatchQueue.main.async {
                diaryState.currentMoimDiaryInfo.moimActivityDtos = diaryState.currentMoimDiaryInfo.moimActivityDtos?.filter {
                    $0.moimActivityId != activityId
                }
            }
            return true
        }
        return false
    }
    
    /// 모임 기록에 대한 개인 메모 추가/수정
    func editMoimDiary(scheduleId: Int, req: ChangeMoimDiaryRequestDTO) async -> Bool {
        return await moimDiaryRepository.editMoimDiary(scheduleId: scheduleId, req: req)
    }
    
    /// 모임 메모 삭제
    func deleteMoimDiary(moimScheduleId: Int) async -> Bool {
        return await moimDiaryRepository.deleteMoimDiary(moimScheduleId: moimScheduleId)
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
    
    /// 모임 메모 상세 조회
    func getOneMoimDiaryDetail(moimScheduleId: Int) async {
        guard let res = await moimDiaryRepository.getOneMoimDiaryDetail(moimScheduleId: moimScheduleId) else { return }
        DispatchQueue.main.async {
            diaryState.currentDiary = res
        }
    }
}
