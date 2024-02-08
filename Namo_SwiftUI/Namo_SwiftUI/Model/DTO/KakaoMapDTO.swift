//
//  KakaoMap.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/8/24.
//

import Foundation

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
struct KakaoMapResponseDTO: Codable {
    let meta: Meta
    let documents: [Document]
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
struct Document: Codable {
    let placeName, distance: String
    let placeURL: String
    let categoryName, addressName, roadAddressName, id: String
    let phone, categoryGroupCode, categoryGroupName, x, y: String

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

extension Document {
    func toPlace() -> Place {
        return .init(id: Int(id) ?? 0,
                     x: Double(x) ?? 0.0,
                     y: Double(y) ?? 0.0,
                     name: placeName,
                     address: addressName,
                     rodeAddress: roadAddressName
        )
    }
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
struct Meta: Codable {
    let sameName: SameName
    let pageableCount, totalCount: Int
    let isEnd: Bool

    enum CodingKeys: String, CodingKey {
        case sameName = "same_name"
        case pageableCount = "pageable_count"
        case totalCount = "total_count"
        case isEnd = "is_end"
    }
}

/// KakaoMap REST API 통신에 사용하는 Response DTO입니다.
struct SameName: Codable {
    let region: [String]
    let keyword, selectedRegion: String

    enum CodingKeys: String, CodingKey {
        case region, keyword
        case selectedRegion = "selected_region"
    }
}
