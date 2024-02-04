//
//  BaseResponse.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation

/// Response를 파싱할 때 사용되는 BaseResponse 구조체입니다.
/// 내부 구조체 T는 Decodable 프로토콜을 준수해야 합니다.
struct BaseResponse<T: Decodable>: Decodable {
    let success: Bool?
    let code: Int?
    let message: String?
    let result: T?
}
