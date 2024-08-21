//
//  DiaryDTO.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 3/16/24.
//

import Foundation

public struct Diary: Decodable {
	public var scheduleId: Int
	public var name: String
	public var startDate: Int
	public var contents: String?
	public var images: [ImageResponse]?
	public var categoryId: Int
	public var color: Int
	public var placeName: String
    
	public init(scheduleId: Int? = nil, name: String? = nil, startDate: Int? = nil, contents: String? = nil, images: [ImageResponse]? = nil, categoryId: Int? = nil, color: Int? = nil, placeName: String? = nil) {
        self.scheduleId = scheduleId ?? -1
        self.name = name ?? ""
        self.categoryId = categoryId ?? -1
        self.startDate = startDate ?? 0
        self.contents = contents ?? ""
        self.images = images ?? []
        self.categoryId = categoryId ?? -1
        self.color = color ?? -1
        self.placeName = placeName ?? ""
    }
}

public struct GetDiaryRequestDTO: Encodable {
	public init(year: Int, month: Int, page: Int, size: Int) {
		self.year = year
		self.month = month
		self.page = page
		self.size = size
	}
	
	public var year: Int
	public var month: Int
	public var page: Int
	public var size: Int
}

public struct GetDiaryResponseDTO: Decodable {
	public init(content: [Diary], currentPage: Int, size: Int, first: Bool, last: Bool) {
		self.content = content
		self.currentPage = currentPage
		self.size = size
		self.first = first
		self.last = last
	}
	
	public var content: [Diary]
	public var currentPage: Int
	public var size: Int
	public var first: Bool
	public var last: Bool
}

/// 개별 기록 조회 API 응답
public struct GetOneDiaryResponseDTO: Decodable {
	public init(contents: String? = nil, images: [ImageResponse]? = nil) {
		self.contents = contents
		self.images = images
	}
	
	public var contents: String?
	public var images: [ImageResponse]?
}

public struct CreateDiaryResponseDTO: Codable {
	public init(scheduleId: Int) {
		self.scheduleId = scheduleId
	}
	
	public let scheduleId: Int
}

public struct ChangeMoimDiaryRequestDTO: Encodable {
	public init(text: String) {
		self.text = text
	}
	
	public let text: String
}

public struct ImageResponse: Decodable, Hashable {
	public init(id: Int, url: String) {
		self.id = id
		self.url = url
	}
	
	public let id: Int
	public let url: String
}
