//
//  KakaoMapMapper.swift
//  DomainSchedule
//
//  Created by 정현우 on 10/8/24.
//

import CoreNetwork

// MARK: - toEntity()

public extension KakaoLocationSearchDocument {
	func toEntity() -> Place {
		return Place(
			id: Int(self.id) ?? 0,
			x: Double(self.x) ?? 0.0,
			y: Double(self.y) ?? 0.0,
			name: self.placeName,
			address: self.addressName,
			rodeAddress: self.roadAddressName
		)
	}
}
