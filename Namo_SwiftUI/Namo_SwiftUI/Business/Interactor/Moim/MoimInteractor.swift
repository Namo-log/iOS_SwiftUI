//
//  MoimInteractor.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//

import Foundation

protocol MoimInteractor {
	func getGroups() async
	func changeMoimName(moimId: Int, newName: String) async -> Bool
	func withdrawGroup(moimId: Int) async -> Bool
	func getMoimSchedule(moimId: Int) async
    func postNewMoimSchedule() async
    func patchMoimSchedule() async
    func deleteMoimSchedule() async
    func setPlaceToCurrentMoimSchedule()
    func setScheduleToCurrentMoimSchedule(schedule: MoimSchedule?)
    func setSelectedUserListToCurrentMoimSchedule(list: [MoimUser])
	func hideToast()
    func patchMoimScheduleCategory(date: Date) async
}
