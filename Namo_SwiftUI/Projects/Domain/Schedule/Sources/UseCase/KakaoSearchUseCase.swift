//
//  KakaoSearchUseCase.swift
//  DomainSchedule
//
//  Created by 정현우 on 10/8/24.
//

import SwiftUI

import ComposableArchitecture

import CoreNetwork

public struct KakaoSearchUseCase {
	public func kakaoLocationSearch(query: String) async -> [Place]? {
		do {
			let response: KakaoLocationSearchResponseDTO = try await APIManager.shared.performRequestWithoutBaseResponse(endPoint: KakaoEndPoint.getKakaoMapAPIRequest(req: KakaoLocationSearchRequest(query: query)))
			
			return response.documents.map({$0.toEntity()})
		} catch(let e) {
			// TODO: error handling
			print(e.localizedDescription)
			return []
		}
	}
}

extension KakaoSearchUseCase: DependencyKey {
	public static var liveValue: KakaoSearchUseCase {
		return KakaoSearchUseCase()
	}
}

extension DependencyValues {
	public var kakaoSearchUseCase: KakaoSearchUseCase {
		get { self[KakaoSearchUseCase.self] }
		set { self[KakaoSearchUseCase.self] = newValue }
	}
}
