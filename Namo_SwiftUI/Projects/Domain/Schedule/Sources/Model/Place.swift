//
//  Place.swift
//  DomainSchedule
//
//  Created by 정현우 on 10/8/24.
//

/// 일정 장소에 사용되는 모델입니다.
public struct Place {
	
	public init(id: Int, x: Double, y: Double, name: String, address: String, rodeAddress: String) {
		self.id = id
		self.x = x
		self.y = y
		self.name = name
		self.address = address
		self.rodeAddress = rodeAddress
	}
	/// id입니다. - KakaoMap 기준
	public let id: Int
	/// 경도입니다 : longitude
	public let x: Double
	/// 위도입니다 : latitude
	public let y: Double
	/// 장소 이름입니다.
	public let name: String
	/// 지번 주소입니다.
	public let address: String
	/// 도로명 주소입니다.
	public let rodeAddress: String
	/// 선택되었는지
	public let isSelected: Bool = false
}
