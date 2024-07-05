//
//  TermDTO.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/3/24.
//

import Foundation

// 약관동의 요청 DTO
struct RegisterTermRequestDTO: Codable {
    
    let isCheckTermOfUse: Bool
    let isCheckPersonalInformationCollection: Bool
}
