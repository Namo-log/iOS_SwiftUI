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
	/// imageKeyName은 request의 body에 들어갈 key이름. 여러 장인 경우 imgs를, 단일 이미지 인경우 img를 넣어 보냄
	/// 정확한 내용은 스웨거 참고
	case uploadImages(imageDatas: [Data?], imageKeyName: String = "imgs")
	/// body 데이터와 함께 이미지를 업로드하는 요청
	/// imageKeyName은 request의 body에 들어갈 key이름. 여러 장인 경우 imgs를, 단일 이미지 인경우 img를 넣어 보냄
	/// 정확한 내용은 스웨거 참고
	case uploadImagesWithBody(imageDatas: [Data?], body: [String: Any], imageKeyName: String = "imgs")
    // 토큰 헤더를 포함하지 않는 인증 요청
    case authRequestJSONEncodable(parameters: Encodable)
    /// 외부 API 요청
    case requestParametersExAPI(parameters: Parameters, encoding: ParameterEncoding)
}
