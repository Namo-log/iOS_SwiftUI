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
typealias GetMonthMoimDiaryResDTO = GetDiaryResponseDTO

/// 단건 모임 메모 조회 Res
struct GetOneMoimDiaryResDTO: Decodable {
    var startDate: Int
    var locationName: String
    var users: [UserDTO]
    var locationDtos: [LocationDTO]
    
    init() {
        self.startDate = 0
        self.locationName = ""
        self.users = []
        self.locationDtos = []
    }
}
struct UserDTO: Decodable {
    var userId: Int
    var userName: String
}
struct LocationDTO: Decodable {
    var moimMemoLocationId: Int
    var name: String
    var money: Int
    var participants: String
    var urls: [String]
}

extension GetOneMoimDiaryResDTO {
    func getMoimUsers() -> [MoimUser] {
        return users.map {
            MoimUser(userId: $0.userId,
                     userName: $0.userName,
                     color: 0)
        }
    }
    
    func getLocationNames() -> [String] {
        locationDtos.map {
            $0.name
        }
    }
}
