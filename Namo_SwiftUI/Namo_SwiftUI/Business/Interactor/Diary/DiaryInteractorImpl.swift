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
    func createDiary(scheduleId: Int, content: String, images: [Data?]) async {
        print("기록 생성 요청")
        print(scheduleId)
        print(content)
        print(images)
        let result = await diaryRepository.createDiary(scheduleId: scheduleId, content: content, images: images)
        print("scheduleId : \(scheduleId)")
    }
    
    /// 월간 기록 조회
    func getMonthDiary(request: GetDiaryRequestDTO) async {
        let diaries = await diaryRepository.getMonthDiary(request: request)?.content ?? []
        print("월간 기록 조회")
        print(diaries)
        DispatchQueue.main.async {
            diaryState.monthDiaries = diaries
        }
    }
    
    /// Date를 받아서 해당 월을 String 값으로 바꿔줌
    /// ex) 06 -> "JUNE"
    func getMonthEngString(date: Date) -> String? {
        // Date 객체에서 월만 문자열로 추출
        let monthString = date.toMM()
        
        // 월 번호를 월 이름으로 변환
        if let monthNumber = Int(monthString), monthNumber >= 1 && monthNumber <= 12 {
            let monthName = DateFormatter().shortMonthSymbols[monthNumber - 1].uppercased()
            return monthName
        }
        
        return nil
    }
    
    /// 기록 변경
    func changeDiary(scheduleId: Int, content: String, images: [Data?]) async -> Bool {
        return await diaryRepository.changeDiary(scheduleId: scheduleId, content: content, images: images)
    }
    
    /// 기록 삭제
    func deleteDiary(scheduleId: Int) async -> Bool {
        return await diaryRepository.deleteDiary(scheduleId: scheduleId)
    }
}
