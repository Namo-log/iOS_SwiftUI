////
////  MoimDTO.swift
////  Namo_SwiftUI
////
////  Created by 정현우 on 2/16/24.
////
//
//import Foundation
//
//import SharedUtil
//
//public struct MoimScheduleDTO: Decodable, Hashable {
//	public init(name: String, startDate: Int, endDate: Int, interval: Int, users: [GroupUser], moimId: Int?, moimScheduleId: Int?, x: Double?, y: Double?, locationName: String?, hasDiaryPlace: Bool, curMoimSchedule: Bool) {
//		self.name = name
//		self.startDate = startDate
//		self.endDate = endDate
//		self.interval = interval
//		self.users = users
//		self.moimId = moimId
//		self.moimScheduleId = moimScheduleId
//		self.x = x
//		self.y = y
//		self.locationName = locationName
//		self.hasDiaryPlace = hasDiaryPlace
//		self.curMoimSchedule = curMoimSchedule
//	}
//	
//    let name: String
//    let startDate: Int
//    let endDate: Int
//    let interval: Int
//    let users: [GroupUser]
//    let moimId: Int?
//    let moimScheduleId: Int?
//    let x: Double?
//    let y: Double?
//    let locationName: String?
//    let hasDiaryPlace: Bool
//    let curMoimSchedule: Bool
//}
//
//public struct MoimSchedule: Decodable, Hashable, Identifiable {
//	public init(id: UUID = UUID(), name: String, startDate: Date, endDate: Date, interval: Int, users: [GroupUser], moimId: Int?, moimScheduleId: Int?, x: Double?, y: Double?, locationName: String?, hasDiaryPlace: Bool, curMoimSchedule: Bool) {
//		self.id = id
//		self.name = name
//		self.startDate = startDate
//		self.endDate = endDate
//		self.interval = interval
//		self.users = users
//		self.moimId = moimId
//		self.moimScheduleId = moimScheduleId
//		self.x = x
//		self.y = y
//		self.locationName = locationName
//		self.hasDiaryPlace = hasDiaryPlace
//		self.curMoimSchedule = curMoimSchedule
//	}
//	
//	public var id = UUID()
//	public let name: String
//	public let startDate: Date
//	public let endDate: Date
//	public let interval: Int
//	public let users: [GroupUser]
//	public let moimId: Int?
//	public let moimScheduleId: Int?
//	public let x: Double?
//	public let y: Double?
//	public let locationName: String?
//	public let hasDiaryPlace: Bool
//	public let curMoimSchedule: Bool
//}
//
//
//public typealias getMoimListResponse = [GroupInfo]
//public typealias getMoimScheduleResponse = [MoimScheduleDTO]
//
//public struct paricipateGroupResponse: Codable {
//	public init(groupId: Int, code: String) {
//		self.groupId = groupId
//		self.code = code
//	}
//	
//	public let groupId: Int
//	public let code: String
//}
//
//public struct createMoimResponse: Decodable {
//	public init(groupId: Int) {
//		self.groupId = groupId
//	}
//	
//	public let groupId: Int
//}
//
//public struct changeMoimNameRequest: Encodable {
//	public init(groupId: Int, groupName: String) {
//		self.groupId = groupId
//		self.groupName = groupName
//	}
//	
//	public let groupId: Int
//	public let groupName: String
//}
//
//public struct CalendarMoimSchedule: Decodable {
//	public init(position: Int, schedule: MoimSchedule?) {
//		self.position = position
//		self.schedule = schedule
//	}
//	
//	public let position: Int
//	public let schedule: MoimSchedule?
//}
//
//public extension MoimScheduleDTO {
//    func toMoimSchedule() -> MoimSchedule {
//        return MoimSchedule(
//            name: name,
//            startDate: Date(timeIntervalSince1970: Double(startDate)),
//            endDate: Date(timeIntervalSince1970: Double(endDate)),
//            interval: interval,
//            users: users,
//            moimId: moimId,
//            moimScheduleId: moimScheduleId,
//            x: x,
//            y: y,
//            locationName: locationName,
//            hasDiaryPlace: hasDiaryPlace,
//            curMoimSchedule: curMoimSchedule
//        )
//    }
//}
//
//public struct postMoimScheduleRequest: Encodable {
//	public init(groupId: Int, name: String, startDate: Int, endDate: Int, interval: Int, x: Double?, y: Double?, locationName: String, users: [Int]) {
//		self.groupId = groupId
//		self.name = name
//		self.startDate = startDate
//		self.endDate = endDate
//		self.interval = interval
//		self.x = x
//		self.y = y
//		self.locationName = locationName
//		self.users = users
//	}
//	
//	public let groupId: Int
//	public let name: String
//	public let startDate: Int
//	public let endDate: Int
//	public let interval: Int
//	public let x: Double?
//	public let y: Double?
//	public let locationName: String
//	public let users: [Int]
//}
//
//public struct patchMoimScheduleRequest: Encodable {
//	public init(moimScheduleId: Int, name: String, startDate: Int, endDate: Int, interval: Int, x: Double?, y: Double?, locationName: String, users: [Int]) {
//		self.moimScheduleId = moimScheduleId
//		self.name = name
//		self.startDate = startDate
//		self.endDate = endDate
//		self.interval = interval
//		self.x = x
//		self.y = y
//		self.locationName = locationName
//		self.users = users
//	}
//	
//	public let moimScheduleId: Int
//	public let name: String
//	public let startDate: Int
//	public let endDate: Int
//	public let interval: Int
//	public let x: Double?
//	public let y: Double?
//	public let locationName: String
//	public let users: [Int]
//}
//
//public struct patchMoimScheduleCategoryRequest: Codable {
//	public init(moimScheduleId: Int, categoryId: Int) {
//		self.moimScheduleId = moimScheduleId
//		self.categoryId = categoryId
//	}
//	
//	public let moimScheduleId: Int
//	public let categoryId: Int
//}
