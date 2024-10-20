//
//  Location.swift
//  DomainPlaceSearch
//
//  Created by 권석기 on 10/21/24.
//

import Foundation

public struct LocationInfo: Equatable {
    public init(placeName: String, 
                x: String,
                y: String,
                addressName: String) {
        self.placeName = placeName
        self.x = x
        self.y = y
        self.addressName = addressName
    }
    
    public let placeName: String
    public let x: String
    public let y: String
    public let addressName: String
}


