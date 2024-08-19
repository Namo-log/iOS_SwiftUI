//
//  Data+.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/31/24.
//

import Foundation
import Alamofire

public extension Data {
    /// Data를 특정 Dicodable DataType과 Decoder에 맞춰 decode합니다.
    ///
    /// - Parameters:
    ///   - type: 디코딩할 타입
    ///   - decoder: 사용할 디코더. 기본값은 `JSONDecoder()`입니다.
    /// - Returns: 디코딩된 Decodable Item
    /// - Throws: 디코딩 과정에서 발생한 에러
    func decode<Item: Decodable, Decoder: DataDecoder>(type: Item.Type, decoder: Decoder = JSONDecoder()) throws -> Item {
        try decoder.decode(type, from: self)
    }
}
