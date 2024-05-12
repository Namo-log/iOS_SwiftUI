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
            print(result)
		} catch {
			ErrorHandler.shared.handleAPIError(.networkError)
			return nil
		}
//		print(String(data: result, encoding: .utf8))
		do {
//            print(String(data: result, encoding: .utf8))
			let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
            
            print(decodedData.code)
            print(decodedData.message)
            
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
    
    // BaseResponse 없는 메소드
    func performRequestWithoutBaseResponse<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> T? {
        do {
            let request = await self.requestData(endPoint: endPoint)
            let result = try request.result.get()
            print("inferred DataType to be decoded : \(T.self)")
            let decodedData = try result.decode(type: T.self, decoder: decoder)
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
          headers: endPoint.headers,
          interceptor: AuthManager()
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
          
      case let .uploadImages(images, imageKeyName):
          return AF.upload(multipartFormData: { multipartFormData in
              for image in images {
				  if let image = image {
					  multipartFormData.append(image, withName: imageKeyName, fileName: "\(image).png", mimeType: "image/png")
				  }
              }
		  }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)")!, method: endPoint.method, headers: endPoint.headers, interceptor: AuthManager())
		  
	  case let .uploadImagesWithBody(images, body, imageKeyName):
		  return AF.upload(multipartFormData: { multipartFormData in
			  for image in images {
				  if let image = image {
					  multipartFormData.append(image, withName: imageKeyName, fileName: "\(image).jpeg", mimeType: "image/jpeg")
				  }
			  }
			  
			  for (key, value) in body {
				  if let data = String(describing: value).data(using: .utf8) {
					  multipartFormData.append(data, withName: key)
				  }
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
          
      case let .requestParametersExAPI(parameters, encoding):
          return AF.request(
            "\(endPoint.baseURL)\(endPoint.path)",
            method: endPoint.method,
            parameters: parameters,
            encoding: encoding,
            headers: endPoint.headers
          )
      }
    }
}

extension APIManager {
    func KakaoMapAPIRequest(query: String, x: Double?=nil, y: Double?=nil, radius: Int?=nil, page: Int?=nil, size: Int?=nil, completion: @escaping (KakaoMapResponseDTO?, Error?) -> Void) {
        
        var params: Parameters = [ "query" : query ]
        
        if let x = x { params["x"] = String(x) }
        if let y = y { params["y"] = String(y) }
        if let radius = radius { params["radius"] = radius }
        if let page = page { params["page"] = page }
        if let size = size { params["size"] = size }
        
        let headers: HTTPHeaders = [ "Authorization" : "KakaoAK \(SecretConstants.kakaoMapRESTAPIKey)"]
        
        AF.request(
            "https://dapi.kakao.com/v2/local/search/keyword.json",
            method: .get,
            parameters: params,
            encoding: URLEncoding.default,
            headers: headers
        )
        .validate()
        .responseDecodable(of: KakaoMapResponseDTO.self) { dataResponse in
            switch dataResponse.result {
            case .success(let success):
                completion(success, nil)
                print(success)
            case .failure(let error):
                print("에러난다:\(error)")
                completion(nil, error)
            }
        }
    }
}
