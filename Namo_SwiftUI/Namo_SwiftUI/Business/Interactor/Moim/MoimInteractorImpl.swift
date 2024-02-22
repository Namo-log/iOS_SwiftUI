//
//  MoimInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//
import Factory

struct MoimInteractorImpl: MoimInteractor {
	@Injected(\.moimRepository) var moimRepository
	@Injected(\.appState) var appState
	
	// 모임 리스트 가져오기
	func getGroups() async -> [Moim] {
		return await moimRepository.getMoimList() ?? []
	}
	
	// 모임 이름 변경
	func changeMoimName(moimId: Int, newName: String) async -> Bool {
		return await moimRepository.changeMoimName(data: changeMoimNameRequest(moimId: moimId, moimName: newName))
	}
	
	// 모임 탈퇴
	func withdrawGroup(moimId: Int) async -> Bool {
		return await moimRepository.withdrawMoim(moimId: moimId)
	}
	
}
