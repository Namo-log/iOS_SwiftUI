//
//  MoimDiaryDTO.swift
//  Namo_SwiftUI
//
//  Created by 서은수 on 4/6/24.
//

import SwiftUI
import Common

/// 모임 메모 장소 생성 & 수정 Req
public struct EditMoimDiaryPlaceReqDTO: Encodable {
	public init(name: String, money: String, participants: [Int], imgs: [Data?]) {
		self.name = name
		self.money = money
		self.participants = participants
		self.imgs = imgs
	}
	
	public var name: String
	public var money: String
	public var participants: [Int]
	public var imgs: [Data?]
}

/// 월간 모임 메모 조회 Req
public struct GetMonthMoimDiaryReqDTO: Encodable {
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

/// 월간 모임 메모 조회 Res
public typealias GetMonthMoimDiaryResDTO = GetDiaryResponseDTO

/// 단건 모임 메모 조회 Res
public struct GetOneMoimDiaryResDTO: Decodable {
	public var name: String
	public var startDate: Int
	public var locationName: String?
	public var users: [UserDTO]?
	public var moimActivityDtos: [ActivityDTO]?
    
	public init() {
        self.name = ""
        self.startDate = 0
        self.locationName = ""
        self.users = []
        self.moimActivityDtos = []
    }
}
public struct UserDTO: Decodable {
	public init(userId: Int, userName: String) {
		self.userId = userId
		self.userName = userName
	}
	
	public var userId: Int
	public var userName: String
}
public struct ActivityDTO: Decodable, Hashable {
	public var moimActivityId: Int
	public var name: String
	public var money: Int
	public var participants: [Int]
	public var images: [ImageResponse]
    
	public init() {
        self.moimActivityId = 0
        self.name = ""
        self.money = 0
        self.participants = []
        self.images = []
    }
    
	public init(id: Int, name: String, money: Int, participants: [Int], images: [ImageResponse]) {
        self.moimActivityId = id
        self.name = name
        self.money = money
        self.participants = participants
        self.images = images
    }
}

public extension GetOneMoimDiaryResDTO {
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
