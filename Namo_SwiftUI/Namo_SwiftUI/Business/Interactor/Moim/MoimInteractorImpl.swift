//
//  MoimInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/16/24.
//
import Factory

struct MoimInteractorImpl: MoimInteractor {
	@Injected(\.moimRepository) var moimRepository
	
	func getGroups() async -> [Moim] {
		return await moimRepository.getMoimList() ?? []
	}
	
}
