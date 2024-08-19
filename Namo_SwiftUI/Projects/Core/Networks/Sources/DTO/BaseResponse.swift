//
//  BaseResponse.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

import Foundation

/// Response를 파싱할 때 사용되는 BaseResponse 구조체입니다.
/// 내부 구조체 T는 Decodable 프로토콜을 준수해야 합니다.
public struct BaseResponse<T: Decodable>: Decodable {
	public let code: Int
	public let message: String
	public let result: T?
	
	
	enum CodingKeys: String, CodingKey {
		case code
		case message
		case result
	}
	
	public init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		code = try container.decode(Int.self, forKey: .code)
		message = try container.decode(String.self, forKey: .message)
		result = try container.decodeIfPresent(T.self, forKey: .result)
	}
}
