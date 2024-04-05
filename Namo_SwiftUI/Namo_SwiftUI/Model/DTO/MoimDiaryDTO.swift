//
//  MoimDiaryDTO.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import Foundation

/// 모임 메모 장소 생성 & 수정 Req
struct EditMoimDiaryPlaceReqDTO: Encodable {
    var name: String
    var money: String
    var participants: String
    var imgs: [Data?]
}

/// 월간 모임 메모 조회 Req
struct GetMonthMoimDiaryReqDTO: Encodable {
    var year: Int
    var month: Int
    var page: Int
    var size: Int
}

/// 월간 모임 메모 조회 Res
typealias GetMoimDiaryResDTO = GetDiaryResponseDTO
