//
//  MoimUseCaseInterface.swift
//  DomainMoim
//
//  Created by 권석기 on 10/2/24.
//

import SwiftUI
import ComposableArchitecture

/// 모임 관련 유스케이스 인터페이스
public struct MoimUseCase {
    public var getMoimList: @Sendable () async throws -> [MoimSchedule]?
    
    public init(getMoimList: @escaping @Sendable () async throws -> [MoimSchedule]?) {
        self.getMoimList = getMoimList
    }
}
