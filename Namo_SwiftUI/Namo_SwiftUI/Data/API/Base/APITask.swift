//
//  AlamoTask.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/31/24.
//

import Foundation
import Alamofire

/// 네트워크 요청 작업을 정의하는 열거형입니다.
public enum APITask {
    /// 추가 데이터 없이 단순한 요청
    case requestPlain
    /// 기본 JSON Encodable을 사용하여 요청
    case requestJSONEncodable(parameters: Encodable)
    /// 커스텀 JSONEncoder를 사용하여 Encodable을 처리하는 요청
    case requestCustomJSONEncodable(parameters: Encodable, encoder: JSONEncoder)
    /// Parameters가 설정된 요청
    case requestParameters(parameters: Parameters, encoding: ParameterEncoding)
    /// 이미지를 업로드하는 요청
    case uploadImages(imageDatas: [Data])
    // 토큰 헤더를 포함하지 않는 인증 요청
    case authRequestJSONEncodable(parameters: Encodable)
    /// 외부 API 요청
    case requestParametersExAPI(parameters: Parameters, encoding: ParameterEncoding)
}
