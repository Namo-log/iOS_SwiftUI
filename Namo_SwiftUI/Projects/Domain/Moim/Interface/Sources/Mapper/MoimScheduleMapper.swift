//
//  MoimScheduleMapper.swift
//  DomainMoimInterface
//
//  Created by 권석기 on 10/3/24.
//

import Foundation
import CoreNetwork
import SharedUtil

public extension MoimScheduleListResponseDTO {
    func toEntity() -> MoimScheduleItem {
        return .init(meetingScheduleId: meetingScheduleId,
                     title: title,
                     startDate: Date.ISO8601toDate(startDate).toYMDEHM(),
                     imageUrl: imageUrl,
                     participantCount: participantCount,
                     participantNicknames: participantNicknames)
    }
}

public extension MoimSchedule {
    func toDto() -> MoimScheduleRequestDTO {
        return .init(title: title,
                     imageUrl: nil,
                     period: .init(startDate: startDate.dateToISO8601(),
                                   endDate: startDate.dateToISO8601()),
                     location: .init(longitude: 0.0, latitude: 0.0, locationName: "어디든", kakaoLocationId: "string"),
                     participants: [0])
    }
}
