//
//  MoimUseCase.swift
//  DomainMoim
//
//  Created by 권석기 on 10/2/24.
//

import Foundation
import ComposableArchitecture
import DomainMoimInterface
import CoreNetwork

// 모임 유즈케이스 구현체
extension MoimUseCase: DependencyKey {
    public static let liveValue = MoimUseCase(
        getMoimList: {
            let response: BaseResponse<[MoimScheduleListResponseDTO]>? = try? await APIManager.shared.performRequest(endPoint: MoimEndPoint.getMoimList)
            guard let data = response?.result else { return [] }
            return data.map { $0.toEntity() }
        },
        createMoim: { moim in
            let response: BaseResponse<Int>? = try? await APIManager.shared.performRequest(endPoint: MoimEndPoint.createMoim(moim.toDto()))
        }
    )
}

extension DependencyValues {
    public var moimUseCase: MoimUseCase {
        get { self[MoimUseCase.self] }
        set { self[MoimUseCase.self] = newValue }
    }
}
