//
//  KakaoMap.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/8/24.
//

import Foundation
import Common

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct KakaoMapResponseDTO: Codable {
	public init(meta: Meta, documents: [Document]) {
		self.meta = meta
		self.documents = documents
	}
	
	public let meta: Meta
	public let documents: [Document]
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct Document: Codable {
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

public extension Document {
    func toPlace() -> Place {
        return .init(id: Int(self.id) ?? 0,
                     x: Double(self.x) ?? 0.0,
                     y: Double(self.y) ?? 0.0,
                     name: self.placeName,
                     address: self.addressName,
                     rodeAddress: self.roadAddressName
        )
    }
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
public struct Meta: Codable {
	public init(sameName: SameName, pageableCount: Int, totalCount: Int, isEnd: Bool) {
		self.sameName = sameName
		self.pageableCount = pageableCount
		self.totalCount = totalCount
		self.isEnd = isEnd
	}
	
	public let sameName: SameName
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
public struct SameName: Codable {
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
