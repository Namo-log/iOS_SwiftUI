//
//  APIManager.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/29/24.
//

import Foundation
import Alamofire

/// 네트워크 요청을 관리하는 싱글톤 클래스인 APIManager입니다.
final class APIManager {
    
    static let shared = APIManager()
    
    private init () { }
    
    /// Endpoint에 따라 네트워크 요청을 수행하고, 결과를 `DataResponse`로 반환합니다.
    ///
    /// - Parameters:
    ///     - `endPoint`: 네트워크 요청을 정의하는 `Endpoint`
    /// - Returns: Alamofire Request 응답 결과인 `DataResponse<Data, AFError>`
    func requestData(endPoint: EndPoint) async -> DataResponse<Data, AFError> {
        let request = makeDataRequest(endPoint: endPoint)
		return await request.serializingData().response
    }
    
    /// 네트워크 요청을 수행하고 결과를 디코딩하여 반환합니다.
    ///
    /// - Parameters:
    ///   - endPoint: 네트워크 요청을 정의하는 Endpoint
    ///   - decoder: 사용할 디코더. 기본값은 `JSONDecoder()`입니다.
    /// - Returns: 디코딩된 결과 데이터 `T: Decodable`
    func performRequest<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> T? {
		var result: Data = .init()
		do {
			let request = await self.requestData(endPoint: endPoint)
			result = try request.result.get()
		} catch {
			ErrorHandler.shared.handleAPIError(.networkError)
			return nil
		}
		
		do {
			let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
			return decodedData.result
		} catch {
			ErrorHandler.shared.handleAPIError(.parseError(error.localizedDescription))
			return nil
		}
    }
    
    // BaseResponse를 반환하는 메소드
    func performRequestBaseResponse<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> BaseResponse<T>? {
        do {
            let request = await self.requestData(endPoint: endPoint)
            let result = try request.result.get()
            print("inferred DataType to be decoded : \(T.self)")
            let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
            return decodedData
        } catch {
            print("에러 발생: \(error)")
            return nil
        }
    }
}

extension APIManager {
    // endpoint의 task에 따라 request 데이터 생성 메서드
    
    /// Endpoint의 task에 따라 request 데이터를 생성하는 메서드입니다.
    ///
    /// - Parameters:
    ///     - `endPoint`: 네트워크 요청을 정의하는 `Endpoint`
    /// - Returns: Alamofire에서 생성한 `DataRequest`
    private func makeDataRequest(endPoint: EndPoint) -> DataRequest {
        
      switch endPoint.task {
          
      case .requestPlain:
        return AF.request(
          "\(endPoint.baseURL)\(endPoint.path)",
          method: endPoint.method,
          headers: endPoint.headers
//          interceptor: AuthManager() // 인터셉터 임시비활성화
        )
        
      case let .requestJSONEncodable(parameters):
          return AF.request(
            "\(endPoint.baseURL)\(endPoint.path)",
            method: endPoint.method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: endPoint.headers,
            interceptor: AuthManager()
          )
        
      case let .requestCustomJSONEncodable(parameters, encoder):
          return AF.request(
            "\(endPoint.baseURL)\(endPoint.path)",
            method: endPoint.method,
            parameters: parameters,
            encoder: .json(encoder: encoder),
            headers: endPoint.headers,
            interceptor: AuthManager()
          )
        
      case let .requestParameters(parameters, encoding):
          return AF.request(
            "\(endPoint.baseURL)\(endPoint.path)",
            method: endPoint.method,
            parameters: parameters,
            encoding: encoding,
            headers: endPoint.headers,
            interceptor: AuthManager()
          )
          
      case let .uploadImages(images):
          return AF.upload(multipartFormData: { multipartFormData in
              for image in images {
                  multipartFormData.append(image, withName: "images", fileName: "\(image).png", mimeType: "image/png")
              }
          }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers, interceptor: AuthManager())
          
          
      case let .authRequestJSONEncodable(parameters):
          return AF.request(
            "\(endPoint.baseURL)\(endPoint.path)",
            method: endPoint.method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: endPoint.headers
          )
      }
    }
}

