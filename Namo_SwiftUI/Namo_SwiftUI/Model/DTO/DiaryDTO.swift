//
//  DiaryDTO.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Foundation

struct Diary: Decodable {
    var scheduleId: Int
    var name: String
    var startDate: Int
    var contents: String?
    var urls: [String]?
    var categoryId: Int
    var color: Int
    var placeName: String
    
    init(scheduleId: Int? = nil, name: String? = nil, startDate: Int? = nil, contents: String? = nil, urls: [String]? = nil, categoryId: Int? = nil, color: Int? = nil, placeName: String? = nil) {
        self.scheduleId = scheduleId ?? -1
        self.name = name ?? ""
        self.categoryId = categoryId ?? -1
        self.startDate = startDate ?? 0
        self.contents = contents ?? ""
        self.urls = urls ?? []
        self.categoryId = categoryId ?? -1
        self.color = color ?? -1
        self.placeName = placeName ?? ""
    }
}

struct GetDiaryRequestDTO: Encodable {
    var year: Int
    var month: Int
    var page: Int
    var size: Int
}

struct GetDiaryResponseDTO: Decodable {
    var content: [Diary]
    var currentPage: Int
    var size: Int
    var first: Bool
    var last: Bool
}

/// 개별 기록 조회 API 응답
struct GetOneDiaryResponseDTO: Decodable {
    var contents: String?
    var urls: [String]?
}

struct CreateDiaryResponseDTO: Codable {
    let scheduleId: Int
}

struct ChangeMoimDiaryRequestDTO: Encodable {
    let text: String
}
