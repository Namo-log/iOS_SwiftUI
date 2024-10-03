//
//  MoimScheduleMapper.swift
//  DomainMoimInterface
//
//  Created by 권석기 on 10/3/24.
//

import Foundation
import CoreNetwork

public extension MoimScheduleListResponseDTO {
    func toEntity() -> MoimScheduleItem {
        return .init(meetingScheduleId: meetingScheduleId,
                     title: title,
                     startDate: Date(timeIntervalSince1970: TimeInterval(startDate)).toYMDEHM(),
                     imageUrl: imageUrl,
                     participantCount: participantCount,
                     participantNicknames: participantNicknames)
    }
}

public extension MoimSchedule {
    func toDto() -> MoimScheduleRequestDTO {
        return .init(title: title,
                     imageUrl: nil,
                     period: .init(startDate: Int(startDate.timeIntervalSince1970), endDate: Int(endDate.timeIntervalSince1970)),
                     location: .init(longitude: 0.0, latitude: 0.0, locationName: "어디든", kakaoLocationId: "string"),
                     participants: [0])
    }
}
