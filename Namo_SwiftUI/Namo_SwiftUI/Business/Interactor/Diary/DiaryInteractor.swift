//
//  DiaryInteractor.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Foundation

protocol DiaryInteractor {
    func createDiary(scheduleId: Int, content: String, images: [Data?]) async
    func getMonthDiary(request: GetDiaryRequestDTO) async
    func getOneDiary(scheduleId: Int) async
    @discardableResult
    func changeDiary(scheduleId: Int, content: String, images: [Data?]) async -> Bool
    func deleteDiary(scheduleId: Int) async -> Bool
    func getMonthEngString(date: Date) -> String?
    func getDateIndicatorIndices(diaries: [Diary]) -> [Int]
}
