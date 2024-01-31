//
//  EndPoint.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/29/24.
//

import Foundation
import Alamofire

/// 네트워크 요청의 Endpoint를 정의하는 프로토콜입니다.
///
/// - `baseURL`: API 요청의 기본 URL 주소
/// - `path`: API 요청의 경로
/// - `method`: API 요청의 HTTP 메서드
/// - `headers`: API 요청에 추가되어야 하는 헤더 정보 (기본값은 `nil`)
/// - `task`: API 요청 시 수행해야 하는 작업 (예: 데이터 전송, 파라미터 전달 등)
protocol EndPoint {
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var task: APITask { get }
}

extension EndPoint {
    /// 기본값으로 `nil`을 반환하며, 요청에 특정 헤더를 추가하려면 해당 프로퍼티를 override 해야합니다.
    var headers: HTTPHeaders? { return nil }
}
