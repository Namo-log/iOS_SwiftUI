//
//  MoimScheduleDTO.swift
//  CoreNetwork
//
//  Created by 권석기 on 10/2/24.
//

import Foundation

// 모임일정 목록 응답 DTO
public struct MoimScheduleListResponseDTO: Decodable {
    public init(meetingScheduleId: Int,
                title: String,
                startDate: String,
                imageUrl: String,
                participantCount: Int,
                participantNicknames: String) {
        self.meetingScheduleId = meetingScheduleId
        self.title = title
        self.startDate = startDate
        self.imageUrl = imageUrl
        self.participantCount = participantCount
        self.participantNicknames = participantNicknames
    }
    public let meetingScheduleId: Int
    public let title: String
    public let startDate: String
    public let imageUrl: String
    public let participantCount: Int
    public let participantNicknames: String
}

// 모임일정 상세 응답 DTO
public struct MoimScheduleResonseDTO: Decodable, Hashable {
    public init(meetingScheduleId: Int,
                title: String,
                startDate: Int,
                imageUrl: String,
                participantCount: Int,
                participantNicknames: [String]) {
        self.meetingScheduleId = meetingScheduleId
        self.title = title
        self.startDate = startDate
        self.imageUrl = imageUrl
        self.participantCount = participantCount
        self.participantNicknames = participantNicknames
    }
    
    public let meetingScheduleId: Int
    public let title: String
    public let startDate: Int
    public let imageUrl: String
    public let participantCount: Int
    public let participantNicknames: [String]
}

// 모임일정 생성 DTO
public struct MoimScheduleRequestDTO: Encodable {
    public init(title: String,
                imageUrl: String?,
                period: PeriodDto,
                location: LocationDto,
                participants: [Int]) {
        self.title = title
        self.imageUrl = imageUrl
        self.period = period
        self.location = location
        self.participants = participants
    }
    public let title: String
    public var imageUrl: String?
    public let period: PeriodDto
    public let location: LocationDto
    public let participants: [Int]
}

public struct PeriodDto: Encodable {
    public init(startDate: String,
                endDate: String) {
        self.startDate = startDate
        self.endDate = endDate
    }
    public let startDate: String
    public let endDate: String
}

public struct LocationDto: Encodable {
    public init(longitude: Double,
                latitude: Double,
                locationName: String,
                kakaoLocationId: String) {
        self.longitude = longitude
        self.latitude = latitude
        self.locationName = locationName
        self.kakaoLocationId = kakaoLocationId
    }
    public let longitude: Double
    public let latitude: Double
    public let locationName: String
    public let kakaoLocationId: String
}
