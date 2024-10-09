//
//  MoimUseCaseInterface.swift
//  DomainMoim
//
//  Created by 권석기 on 10/2/24.
//

import UIKit
import ComposableArchitecture
import CoreNetwork

/// 모임 관련 유스케이스 인터페이스
public struct MoimUseCase {
    public var getMoimList: @Sendable () async throws -> [MoimScheduleItem]
    public var createMoim: @Sendable (MoimSchedule, UIImage?) async throws -> Void
    public var getMoimDetail: @Sendable (_ meetingScheduleId: Int) async throws -> MoimSchedule
    public var withdrawMoim: @Sendable (_ meetingScheduleId: Int) async throws -> Void
    public var editMoim: @Sendable (_ moim: MoimSchedule, UIImage?) async throws -> Void
    
    public init(getMoimList: @escaping @Sendable () async throws -> [MoimScheduleItem],
                createMoim: @escaping @Sendable (MoimSchedule, UIImage?) async throws -> Void,
                getMoimDetail: @escaping @Sendable (_ meetingScheduleId: Int) async throws -> MoimSchedule,
                withdrawMoim: @escaping @Sendable (_ meetingScheduleId: Int) async throws -> Void,
                editMoim: @escaping @Sendable (_ moim: MoimSchedule, UIImage?) async throws -> Void) {
        self.getMoimList = getMoimList
        self.createMoim = createMoim
        self.getMoimDetail = getMoimDetail
        self.withdrawMoim = withdrawMoim
        self.editMoim = editMoim
    }
}
