//
//  MoimDiaryDTO.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import SwiftUI

/// 모임 메모 장소 생성 & 수정 Req
struct EditMoimDiaryPlaceReqDTO: Encodable {
    var name: String
    var money: String
    var participants: [Int]
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
    var name: String
    var startDate: Int
    var locationName: String?
    var users: [UserDTO]?
    var moimActivityDtos: [ActivityDTO]?
    
    init() {
        self.name = ""
        self.startDate = 0
        self.locationName = ""
        self.users = []
        self.moimActivityDtos = []
    }
}
struct UserDTO: Decodable {
    var userId: Int
    var userName: String
}
struct ActivityDTO: Decodable, Hashable {
    var moimActivityId: Int
    var name: String
    var money: Int
    var participants: [Int]
    var images: [ImageResponse]
    
    init() {
        self.moimActivityId = 0
        self.name = ""
        self.money = 0
        self.participants = []
        self.images = []
    }
    
    init(id: Int, name: String, money: Int, participants: [Int], images: [ImageResponse]) {
        self.moimActivityId = id
        self.name = name
        self.money = money
        self.participants = participants
        self.images = images
    }
}

extension GetOneMoimDiaryResDTO {
    func getMoimUsers() -> [GroupUser] {
        users?.map {
            GroupUser(userId: $0.userId,
                     userName: $0.userName,
                     color: 0)
        } ?? []
    }
    
    func getActivityNames() -> [String] {
        moimActivityDtos?.map {
            $0.name
        } ?? []
    }
    
    func getActivityIdList() -> [Int] {
        moimActivityDtos?.map {
            $0.moimActivityId
        } ?? []
    }
}
