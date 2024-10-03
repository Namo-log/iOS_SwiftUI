//
//  MoimSchedule.swift
//  DomainMoim
//
//  Created by 권석기 on 10/2/24.
//

import Foundation

public struct MoimSchedule: Decodable, Hashable {
    public init(title: String,
                imageUrl: String,
                startDate: Date,
                endDate: Date,
                longitude: Double,
                latitude: Double,
                locationName: String,
                kakaoLocationId: String,
                participants: [String]) {
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
    
    public let title: String
    public let imageUrl: String
    public let startDate: Date
    public let endDate: Date
    public let longitude: Double
    public let latitude: Double
    public let locationName: String
    public let kakaoLocationId: String
    public let participants: [String]
}
