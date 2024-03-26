//
//  DiaryRepository.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Foundation

protocol DiaryRepository {
    func createDiary(scheduleId: String, content: String, images: [Data?]) async -> CreateDiaryResponseDTO?
    func getMonthDiary(request: GetDiaryRequestDTO) async -> GetDiaryResponseDTO?
    func changeDiary(scheduleId: String, content: String, images: [Data?]) async -> Bool
    func deleteDiary(diaryId: Int) async -> Bool
}