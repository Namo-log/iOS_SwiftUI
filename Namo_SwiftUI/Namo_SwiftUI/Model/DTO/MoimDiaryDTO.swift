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
struct ActivityDTO: Decodable {
    var moimActivityId: Int
    var name: String
    var money: Int
    var participants: [Int]
    var urls: [String]
    
    init() {
        self.moimActivityId = 0
        self.name = ""
        self.money = 0
        self.participants = []
        self.urls = []
    } 
    
    init(id: Int, name: String, money: Int, participants: [Int], urls: [String]) {
        self.moimActivityId = id
        self.name = name
        self.money = money
        self.participants = participants
        self.urls = urls
    }
}

extension GetOneMoimDiaryResDTO {
    func getMoimUsers() -> [MoimUser] {
        users?.map {
            MoimUser(userId: $0.userId,
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

extension ActivityDTO {
    func getDataList() -> [Data] {
        var dataList: [Data] = []
        for url in urls {
            guard let url = URL(string: url) else { return [] }
            
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                dataList.append(data)
            }
        }
        return dataList
    }
    
    mutating func toUrlString(dataList: [Data?]) {
        
        urls = dataList.compactMap { data in
            guard let data = data else { return nil }
            // Data를 String으로 변환
            guard let urlString = String(data: data, encoding: .utf8) else {
                return nil
            }
            // 변환된 문자열이 유효한 URL인지 확인
            guard URL(string: urlString) != nil else {
                return nil
            }
            return urlString
        }

    }
}
