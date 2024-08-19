//
//  MoimDiaryUseCase.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Factory
import SwiftUI
import Networks

/// 모임 기록 API
final class MoimDiaryUseCase {
	static let shared = MoimDiaryUseCase()
    @Injected(\.diaryState) private var diaryState
    @Injected(\.moimDiaryRepository) var moimDiaryRepository
    
    /// 모임 메모 장소 생성
    func createMoimDiaryPlace(moimScheduleId: Int, req: EditMoimDiaryPlaceReqDTO) async -> Bool {
        print("모임 기록 생성 요청 \(req)")
        return await moimDiaryRepository.createMoimDiaryPlace(moimScheduleId: moimScheduleId, req: req)
    }
    
    /// 모임 메모 장소 수정
	func changeMoimDiaryPlace(activityId: Int, req: EditMoimDiaryPlaceReqDTO, deleteImageIds: [Int]) async -> Bool {
		return await moimDiaryRepository.changeMoimDiaryPlace(activityId: activityId, req: req, deleteImageIds: deleteImageIds)
    }
    
    /// 모임 메모 장소 삭제
    func deleteMoimDiaryPlace(activityId: Int) async -> Bool {
        if await moimDiaryRepository.deleteMoimDiaryPlace(activityId: activityId) {
            DispatchQueue.main.async {
				self.diaryState.currentMoimDiaryInfo.moimActivityDtos = self.diaryState.currentMoimDiaryInfo.moimActivityDtos?.filter {
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
	@MainActor
    func getMonthMoimDiary(req: GetMonthMoimDiaryReqDTO) async {
        var diaries = await moimDiaryRepository.getMonthMoimDiary(req: req)?.content ?? []
        print("월간 모임 기록 조회")
		if req.page == 0 {
			self.diaryState.monthDiaries = diaries
		} else {
			self.diaryState.monthDiaries += diaries
		}
    }
    
    /// 단건 모임 메모 조회
	@MainActor
    func getOneMoimDiary(moimScheduleId: Int) async {
        guard let res = await moimDiaryRepository.getOneMoimDiary(moimScheduleId: moimScheduleId) else { return }
		diaryState.currentMoimDiaryInfo = res
    }
    
    /// 모임 메모 상세 조회
	@MainActor
    func getOneMoimDiaryDetail(moimScheduleId: Int) async {
        guard let res = await moimDiaryRepository.getOneMoimDiaryDetail(moimScheduleId: moimScheduleId) else { return }
		diaryState.currentDiary = res
    }
    
    /// 개인 페이지 모임 기록 삭제
    func deleteMoimDiaryOnPersonal(scheduleId: Int) async -> Bool {
        
        return await moimDiaryRepository.deleteMoimDiaryOnPersonal(scheduleId: scheduleId)
    }
}
