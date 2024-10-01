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

extension MoimUseCase: DependencyKey {
    public static let liveValue = MoimUseCase(
        getMoimList: {
            let response: BaseResponse<[MoimScheduleDTO]>? = await APIManager.shared.performRequest(endPoint: MoimEndPoint.getMoimList)
            return response?.result
        }
    )
}

extension DependencyValues {
    public var moimUseCase: MoimUseCase {
        get { self[MoimUseCase.self] }
        set { self[MoimUseCase.self] = newValue }
    }
}
