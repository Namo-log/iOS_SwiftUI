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
	let moimUsers: [MoimUser]
}

struct MoimUser: Decodable {
	let userId: Int
	let userName: String
	let color: Int
}

typealias getMoimListResponse = [Moim]

struct createMoimResponse: Decodable {
	let moimId: Int
}

struct changeMoimNameRequest: Encodable {
	let moimId: Int
	let moimName: String
}
