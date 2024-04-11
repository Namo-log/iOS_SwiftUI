//
//  MoimInteractor.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

protocol MoimInteractor {
	func getGroups() async
	func changeMoimName(moimId: Int, newName: String) async -> Bool
	func withdrawGroup(moimId: Int) async -> Bool
	func getMoimSchedule(moimId: Int) async
}
