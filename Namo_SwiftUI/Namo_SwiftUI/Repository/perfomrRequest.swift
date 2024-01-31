//
//  perfomrRequest.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/31/24.
//

import Foundation

// 제네릭의 신비..

/// 네트워크 요청을 수행하고 결과를 디코딩하여 반환합니다.
///
/// - Parameters:
///   - endPoint: 네트워크 요청을 정의하는 Endpoint
///   - decoder: 사용할 디코더. 기본값은 `JSONDecoder()`입니다.
/// - Returns: 디코딩된 결과 데이터 `T: Decodable`
func performRequest<T: Decodable>(endPoint: EndPoint, decoder: JSONDecoder = JSONDecoder()) async -> T? {
    do {
        let request = await APIManager.shared.requestData(endPoint: endPoint)
        let result = try request.result.get()
        print("inferred DataType to be decoded : \(T.self)")
        let decodedData = try result.decode(type: T.self, decoder: decoder)
        return decodedData
    } catch {
        print("에러 발생: \(error)")
        return nil
    }
}
