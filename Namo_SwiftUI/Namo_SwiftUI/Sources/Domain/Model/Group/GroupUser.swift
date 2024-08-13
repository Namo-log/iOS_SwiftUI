//
//  GroupUser.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 7/16/24.
//

import Foundation

struct GroupUser: Decodable, Equatable, Hashable {
	let userId: Int
	let userName: String
	let color: Int
}
