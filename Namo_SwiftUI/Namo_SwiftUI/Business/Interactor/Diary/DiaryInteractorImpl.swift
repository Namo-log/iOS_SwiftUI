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
        var diaries = await diaryRepository.getMonthDiary(request: request)?.content ?? []
        print("월간 기록 조회")
        print(diaries)
        DispatchQueue.main.async {
            if request.page == 0 {
                diaryState.monthDiaries = diaries
            } else {
                diaryState.monthDiaries += diaries
            }
        }
    }
    
    /// 기록 개별 조회
    func getOneDiary(scheduleId: Int) async {
        var diary = await diaryRepository.getOneDiary(scheduleId: scheduleId)
        print("기록 개별 조회")
        print(diary)
        DispatchQueue.main.async {
            diaryState.currentDiary.contents = diary?.contents
            diaryState.currentDiary.urls = diary?.urls
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
    
    /// 날짜가 이전 다이어리와 달라지는 부분의 인덱스들을 반환
    /// 기록 메인 화면에서 기록의 날짜 뷰를 띄울 때에 사용
    func getDateIndicatorIndices(diaries: [Diary]) -> [Int] {
        var indices: [Int] = []
        var prev: String? = nil // 이전 다이어리의 날짜
        
        for idx in 0..<diaries.count {
            let diary = diaries[idx]
            if prev != Date(timeIntervalSince1970: Double(diary.startDate)).toYMDString() {
                indices.append(idx) // 바뀌는 부분의 index 추가
            }
            prev = Date(timeIntervalSince1970: Double(diary.startDate)).toYMDString()
        }
        
        return indices
    }
}
