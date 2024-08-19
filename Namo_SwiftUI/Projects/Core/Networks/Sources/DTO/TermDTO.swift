//
//  TermDTO.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/3/24.
//

import Foundation

// 약관동의 요청 DTO
public struct RegisterTermRequestDTO: Codable {
	public init(isCheckTermOfUse: Bool, isCheckPersonalInformationCollection: Bool) {
		self.isCheckTermOfUse = isCheckTermOfUse
		self.isCheckPersonalInformationCollection = isCheckPersonalInformationCollection
	}
	
    public let isCheckTermOfUse: Bool
    public let isCheckPersonalInformationCollection: Bool
}
