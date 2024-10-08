//
//  MoimSchedule.swift
//  DomainMoim
//
//  Created by 권석기 on 10/2/24.
//

import Foundation
import CoreNetwork

public struct MoimSchedule: Decodable, Hashable {
    public init(scheduleId: Int,
                title: String,
                imageUrl: String,
                startDate: Date,
                endDate: Date,
                longitude: Double,
                latitude: Double,
                locationName: String,
                kakaoLocationId: String,
                participants: [Participant]) {
        self.scheduleId = scheduleId
        self.title = title
        self.imageUrl = imageUrl
        self.startDate = startDate
        self.endDate = endDate
        self.longitude = longitude
        self.latitude = latitude
        self.locationName = locationName
        self.kakaoLocationId = kakaoLocationId
        self.participants = participants
    }
    public let scheduleId: Int
    public let title: String
    public let imageUrl: String
    public let startDate: Date
    public let endDate: Date
    public let longitude: Double
    public let latitude: Double
    public let locationName: String
    public let kakaoLocationId: String
    public let participants: [Participant]
}

public struct Participant: Decodable, Hashable {
    public init(participantId: Int, 
                userId: Int,
                isGuest: Bool,
                nickname: String,
                colorId: Int?,
                isOwner: Bool) {
        self.participantId = participantId
        self.userId = userId
        self.isGuest = isGuest
        self.nickname = nickname
        self.colorId = colorId
        self.isOwner = isOwner
    }
    public let participantId: Int
    public let userId: Int
    public let isGuest: Bool
    public let nickname: String
    public let colorId: Int?
    public let isOwner: Bool
}

public extension MoimSchedule {
    var isOwner: Bool {
        participants.firstIndex(where: { $0.isOwner && $0.userId == UserDefaults.standard.integer(forKey: "userId")}) != nil
    }
}
