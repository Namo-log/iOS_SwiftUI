//
//  GroupUser.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/16/24.
//

import Foundation

public struct GroupUser: Decodable, Equatable, Hashable {
	public init(userId: Int, userName: String, color: Int) {
		self.userId = userId
		self.userName = userName
		self.color = color
	}
	public let userId: Int
	public let userName: String
	public let color: Int
}
