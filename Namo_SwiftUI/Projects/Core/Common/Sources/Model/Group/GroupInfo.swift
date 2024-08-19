//
//  GroupInfo.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/16/24.
//

import Foundation

public struct GroupInfo: Decodable, Hashable {
	public let groupId: Int
	public var groupName: String?
	public let groupImgUrl: String?
	public let groupCode: String
	public let groupUsers: [GroupUser]
	
	public init(
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
