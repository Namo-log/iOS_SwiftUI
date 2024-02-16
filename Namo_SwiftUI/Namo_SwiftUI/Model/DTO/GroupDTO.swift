//
//  GroupDTO.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

import Foundation

struct GroupDTO {
	let groupId: Int
	let groupName: String?
	let groupImageUrl: String?
	let groupCode: String
	let moimUsers: [GroupUser]
}

struct GroupUser {
	let userId: Int
	let userName: String
	let userColor: Int
}
