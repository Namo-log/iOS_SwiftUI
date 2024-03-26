//
//  DiaryInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Factory
import SwiftUI

struct DiaryInteractorImpl: DiaryInteractor {
    @Injected(\.diaryRepository) var diaryRepository
    @Injected(\.appState) private var appState
    @Injected(\.diaryState) private var diaryState
    
    /// 기록 생성
    func createDiary(scheduleId: String, content: String, images: [Data?]) async {
        let result = await diaryRepository.createDiary(scheduleId: scheduleId, content: content, images: images)
        print("생성된 기록 id : \(result?.scheduleIdx ?? -1)")
    }
    
    /// 월간 기록 조회
    func getMonthDiary(request: GetDiaryRequestDTO) async {
        let diaries = await diaryRepository.getMonthDiary(request: request)?.content ?? []
        print("월간 기록 조회")
        DispatchQueue.main.async {
            diaryState.monthDiaries = diaries
        }
    }
    
    /// 기록 변경
    func changeDiary(scheduleId: String, content: String, images: [Data?]) async -> Bool {
        return await diaryRepository.changeDiary(scheduleId: scheduleId, content: content, images: images)
    }
    
    /// 기록 삭제
    func deleteDiary(diaryId: Int) async -> Bool {
        return await diaryRepository.deleteDiary(diaryId: diaryId)
    }
}
