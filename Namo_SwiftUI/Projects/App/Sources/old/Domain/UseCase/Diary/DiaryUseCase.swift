////
////  DiaryUseCase.swift
////  Namo_SwiftUI
////
////  Created by 서은수 on 3/16/24.
////
//
//import Factory
//import SwiftUI
//
//import CoreNetwork
//
//final class DiaryUseCase {
//	static let shared = DiaryUseCase()
//    @Injected(\.diaryRepository) var diaryRepository
//    @Injected(\.diaryState) private var diaryState
//    
//    /// 기록 생성
//    func createDiary(scheduleId: Int, content: String, images: [Data?]) async {
//        print("기록 생성 요청")
//		print(images.first)
//        let result = await diaryRepository.createDiary(scheduleId: scheduleId, content: content, images: images)
//		if result != nil {
//			// 기록 저장에 성공하고 Realm에 해당 item이 있는 경우
//			// TODO: 페이징 구현 후 적용
////			if let schedule = RealmManager.shared.getObject(RealmSchedule.self, pk: scheduleId) {
////				schedule.hasDiary = true
////				print(schedule)
////				RealmManager.shared.updateObject(schedule, pk: scheduleId)
////			}
//			await MainActor.run {
//				NotificationCenter.default.post(name: .reloadCalendarViaNetwork, object: nil)
//			}
//		}
//    }
//    
//    /// 월간 기록 조회
//	@MainActor
//    func getMonthDiary(request: GetDiaryRequestDTO) async {
//		var diaries = await diaryRepository.getMonthDiary(request: request)?.content ?? []
//		if request.page == 0 {
//			diaryState.monthDiaries = diaries
//		} else {
//			diaryState.monthDiaries += diaries
//		}
//    }
//    
//    /// 기록 개별 조회
//	@MainActor
//    func getOneDiary(scheduleId: Int) async {
//        let diary = await diaryRepository.getOneDiary(scheduleId: scheduleId)
//		diaryState.currentDiary.contents = diary?.contents
//		diaryState.currentDiary.images = diary?.images
//    }
//    
//    /// Date를 받아서 해당 월을 String 값으로 바꿔줌
//    /// ex) 06 -> "JUNE"
//    func getMonthEngString(date: Date) -> String? {
//        // Date 객체에서 월만 문자열로 추출
//        let monthString = date.toMM()
//        
//        // 월 번호를 월 이름으로 변환
//        if let monthNumber = Int(monthString), monthNumber >= 1 && monthNumber <= 12 {
//            let monthName = DateFormatter().shortMonthSymbols[monthNumber - 1].uppercased()
//            return monthName
//        }
//        
//        return nil
//    }
//    
//    /// 기록 변경
//	func changeDiary(scheduleId: Int, content: String, images: [Data?], deleteImageIds: [Int]) async -> Bool {
//		print(deleteImageIds)
//		return await diaryRepository.changeDiary(scheduleId: scheduleId, content: content, images: images, deleteImageIds: deleteImageIds)
//    }
//    
//    /// 기록 삭제
//    @discardableResult
//    func deleteDiary(scheduleId: Int) async -> Bool {
//        return await diaryRepository.deleteDiary(scheduleId: scheduleId)
//    }
//    
//    /// 날짜가 이전 다이어리와 달라지는 부분의 인덱스들을 반환
//    /// 기록 메인 화면에서 기록의 날짜 뷰를 띄울 때에 사용
//    func getDateIndicatorIndices(diaries: [Diary]) -> [Int] {
//        var indices: [Int] = []
//        var prev: String? = nil // 이전 다이어리의 날짜
//        
//        for idx in 0..<diaries.count {
//            let diary = diaries[idx]
//            if prev != Date(timeIntervalSince1970: Double(diary.startDate)).toYMDString() {
//                indices.append(idx) // 바뀌는 부분의 index 추가
//            }
//            prev = Date(timeIntervalSince1970: Double(diary.startDate)).toYMDString()
//        }
//        
//        return indices
//    }
//}
