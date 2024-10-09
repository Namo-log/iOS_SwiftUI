//
//  KakaoSearchDTO.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/8/24.
//

import Foundation

import SharedUtil

public struct KakaoLocationSearchRequest: Codable {
	public let query: String
	public let x: Double?
	public let y: Double?
	public let radius: Int?
	public let page: Int?
	public let size: Int?
	
	public init(
		query: String,
		x: Double? = nil,
		y: Double? = nil,
		radius: Int? = nil,
		page: Int? = nil,
		size: Int? = nil
	) {
		self.query = query
		self.x = x
		self.y = y
		self.radius = radius
		self.page = page
		self.size = size
	}
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct KakaoLocationSearchResponseDTO: Codable {
	public init(meta: KakaoLocationSearchMeta, documents: [KakaoLocationSearchDocument]) {
		self.meta = meta
		self.documents = documents
	}
	
	public let meta: KakaoLocationSearchMeta
	public let documents: [KakaoLocationSearchDocument]
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct KakaoLocationSearchDocument: Codable {
	public init(placeName: String, distance: String, placeURL: String, categoryName: String, addressName: String, roadAddressName: String, id: String, phone: String, categoryGroupCode: String, categoryGroupName: String, x: String, y: String) {
		self.placeName = placeName
		self.distance = distance
		self.placeURL = placeURL
		self.categoryName = categoryName
		self.addressName = addressName
		self.roadAddressName = roadAddressName
		self.id = id
		self.phone = phone
		self.categoryGroupCode = categoryGroupCode
		self.categoryGroupName = categoryGroupName
		self.x = x
		self.y = y
	}
	
	public let placeName, distance: String
	public let placeURL: String
	public let categoryName, addressName, roadAddressName, id: String
	public let phone, categoryGroupCode, categoryGroupName, x, y: String

    enum CodingKeys: String, CodingKey {
        case placeName = "place_name"
        case distance
        case placeURL = "place_url"
        case categoryName = "category_name"
        case addressName = "address_name"
        case roadAddressName = "road_address_name"
        case id, phone
        case categoryGroupCode = "category_group_code"
        case categoryGroupName = "category_group_name"
        case x, y
    }
}


/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct KakaoLocationSearchMeta: Codable {
	public init(sameName: KakaoLocationSearchSameName, pageableCount: Int, totalCount: Int, isEnd: Bool) {
		self.sameName = sameName
		self.pageableCount = pageableCount
		self.totalCount = totalCount
		self.isEnd = isEnd
	}
	
	public let sameName: KakaoLocationSearchSameName
	public let pageableCount, totalCount: Int
	public let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case sameName = "same_name"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
        case isEnd = "is_end"
    }
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct KakaoLocationSearchSameName: Codable {
	public init(region: [String], keyword: String, selectedRegion: String) {
		self.region = region
		self.keyword = keyword
		self.selectedRegion = selectedRegion
	}
	
	public let region: [String]
	public let keyword, selectedRegion: String

    enum CodingKeys: String, CodingKey {
        case region, keyword
        case selectedRegion = "selected_region"
    }
}
