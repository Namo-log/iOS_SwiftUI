//
//  MoimDTO.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

import Foundation

struct Moim: Decodable {
    let groupId: Int
    var groupName: String?
    let groupImgUrl: String?
    let groupCode: String
    let groupUsers: [MoimUser]
    
    init(
        groupId: Int = -1,
        groupName: String? = nil,
        groupImgUrl: String? = nil,
        groupCode: String = "",
		groupUsers: [MoimUser] = []
    ) {
        self.groupId = groupId
        self.groupName = groupName
        self.groupImgUrl = groupImgUrl
        self.groupCode = groupCode
        self.groupUsers = groupUsers
    }
}

struct MoimScheduleDTO: Decodable, Hashable {
    let name: String
    let startDate: Int
    let endDate: Int
    let interval: Int
    let users: [MoimUser]
    let moimId: Int?
    let moimScheduleId: Int?
    let x: Double?
    let y: Double?
    let locationName: String?
    let hasDiaryPlace: Bool
    let curMoimSchedule: Bool
}

struct MoimSchedule: Decodable, Hashable, Identifiable {
    var id = UUID()
    let name: String
    let startDate: Date
    let endDate: Date
    let interval: Int
    let users: [MoimUser]
    let moimId: Int?
    let moimScheduleId: Int?
    let x: Double?
    let y: Double?
    let locationName: String?
    let hasDiaryPlace: Bool
    let curMoimSchedule: Bool
}

struct MoimUser: Decodable, Equatable, Hashable {
    let userId: Int
    let userName: String
    let color: Int
}

typealias getMoimListResponse = [Moim]
typealias getMoimScheduleResponse = [MoimScheduleDTO]

struct paricipateGroupResponse: Codable {
	let groupId: Int
	let code: String
}

struct createMoimResponse: Decodable {
    let groupId: Int
}

struct changeMoimNameRequest: Encodable {
    let groupId: Int
    let groupName: String
}

struct CalendarMoimSchedule: Decodable {
    let position: Int
    let schedule: MoimSchedule?
}

extension MoimScheduleDTO {
    func toMoimSchedule() -> MoimSchedule {
        return MoimSchedule(
            name: name,
            startDate: Date(timeIntervalSince1970: Double(startDate)),
            endDate: Date(timeIntervalSince1970: Double(endDate)),
            interval: interval,
            users: users,
            moimId: moimId,
            moimScheduleId: moimScheduleId,
            x: x,
            y: y,
            locationName: locationName,
            hasDiaryPlace: hasDiaryPlace,
            curMoimSchedule: curMoimSchedule
        )
    }
}

struct postMoimScheduleRequest: Encodable {
    let groupId: Int
    let name: String
    let startDate: Int
    let endDate: Int
    let interval: Int
    let x: Double?
    let y: Double?
    let locationName: String
    let users: [Int]
}

struct patchMoimScheduleRequest: Encodable {
    let moimScheduleId: Int
    let name: String
    let startDate: Int
    let endDate: Int
    let interval: Int
    let x: Double?
    let y: Double?
    let locationName: String
    let users: [Int]
}
