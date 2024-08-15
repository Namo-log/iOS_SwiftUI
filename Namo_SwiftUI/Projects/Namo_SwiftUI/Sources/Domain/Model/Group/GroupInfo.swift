//
//  GroupInfo.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/16/24.
//

import Foundation

struct GroupInfo: Decodable, Hashable {
	let groupId: Int
	var groupName: String?
	let groupImgUrl: String?
	let groupCode: String
	let groupUsers: [GroupUser]
	
	init(
		groupId: Int = -1,
		groupName: String? = nil,
		groupImgUrl: String? = nil,
		groupCode: String = "",
		groupUsers: [GroupUser] = []
	) {
		self.groupId = groupId
		self.groupName = groupName
		self.groupImgUrl = groupImgUrl
		self.groupCode = groupCode
		self.groupUsers = groupUsers
	}
}
