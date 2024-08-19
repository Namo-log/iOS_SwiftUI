//
//  APIManager.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/29/24.
//

import Foundation
import Alamofire
import Common

/// 네트워크 요청을 관리하는 싱글톤 클래스인 APIManager입니다.
public final class APIManager {
    
    public static let shared = APIManager()
    
    private init () { }
    
    /// Endpoint에 따라 네트워크 요청을 수행하고, 결과를 `DataResponse`로 반환합니다.
    ///
    /// - Parameters:
    ///     - `endPoint`: 네트워크 요청을 정의하는 `Endpoint`
    /// - Returns: Alamofire Request 응답 결과인 `DataResponse<Data, AFError>`
	public func requestData(endPoint: EndPoint) async -> DataResponse<Data, AFError> {
                 
        var response = await makeDataRequest(endPoint: endPoint).serializingData().response
        
        // HTTP Status가 403일 때(토큰이 만료되었을 때)
        if let statusCode = response.response?.statusCode, statusCode == 403 {


            guard await ReissuanceToken() else {
                
                // 토큰 갱신에 실패한 경우
                
                print("==== 토큰 갱신 실패로 로그아웃 처리됨 ====")

                // 로그아웃 처리
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: "isLogin")
                }
                return response
            }
            
            // 토큰 갱신에 성공한 경우
            // 원래 요청을 다시 시도
            response = await makeDataRequest(endPoint: endPoint).serializingData().response
        }
        return response
    }
    
    // 토큰 재발급
	public func ReissuanceToken() async -> Bool {
        
        guard let accessToken = KeyChainManager.readItem(key: "accessToken"),
              let refreshToken = KeyChainManager.readItem(key: "refreshToken") else {
            
            // 기존에 가지고 있던 토큰 확인 후 토큰이 없는 경우 false를 반환함으로써 requestData() 내부에서 로그아웃 처리로 이어짐
            print("==== 토큰이 없어서 로그아웃 처리됨 ====")
            return false
        }
        
        // 기존에 가지고 있던 토큰이 있는 경우 토큰 재발급 요청을 보냄
        let response = await makeDataRequest(endPoint: AuthEndPoint.reissuanceToken(token: TokenReissuanceRequestDTO(accessToken: accessToken, refreshToken: refreshToken))).serializingData().response
        
        // 토큰 재발급 응답이 403일 경우 == RefreshToken도 만료되었을 경우
        if response.response?.statusCode == 403 {
            
            print("====토큰 갱신 실패로 로그아웃 처리됨(APIManager)====")

            // 로그아웃 처리
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
            }
            return false
        }
        
        // 토큰 재발급이 정상적으로 이루어졌을 경우
        
        print("리프래시 토큰으로 액세스 토큰 재발급")
        print("리프래시 토큰도 재발급됨.")
        
        var result: Data = .init()
        
        do {
            result = try response.result.get()
            
            // 새롭게 발급받은 토큰을 키체인에 저장
            let decodedData = try result.decode(type: BaseResponse<TokenReissuanceResponseDTO>.self, decoder: JSONDecoder())
			
			if let tokens = decodedData.result {
				KeyChainManager.addItem(key: "accessToken", value: tokens.accessToken)
				KeyChainManager.addItem(key: "refreshToken", value: tokens.refreshToken)
				
			} else {
				return false
			}
            
        } catch {
            
            print("토큰 재발급 후 저장 과정에서 에러!")
        }
        
        return true
    }
    
    
    // 이전에 사용하는 performRequest.
	// 리팩토링 시 제거 필요
	public func performRequestOld<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> T? {
		var result: Data = .init()
		do {
			let request = await self.requestData(endPoint: endPoint)
            
			result = try request.result.get()
		} catch {
			print("네트워크 에러" + (String(data: result, encoding: .utf8) ?? ""))
			ErrorHandler.shared.handleAPIError(.networkError)
			return nil
		}

		do {

			let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
            
			return decodedData.result
		} catch {
			print("디코딩 에러" + (String(data: result, encoding: .utf8) ?? ""))
			ErrorHandler.shared.handleAPIError(.parseError(error.localizedDescription))
			return nil
		}
    }
    
	/// 네트워크 요청을 수행하고 결과를 디코딩하여 반환합니다.
	///
	/// - Parameters:
	///   - endPoint: 네트워크 요청을 정의하는 Endpoint
	///   - decoder: 사용할 디코더. 기본값은 `JSONDecoder()`입니다.
	/// - Returns: 디코딩된 Response
	public func performRequest<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> BaseResponse<T>? {
		var result: Data = .init()
		do {
			let request = await self.requestData(endPoint: endPoint)
			
			result = try request.result.get()
		} catch {
			print("네트워크 에러" + (String(data: result, encoding: .utf8) ?? ""))
			ErrorHandler.shared.handleAPIError(.networkError)
			return nil
		}

		do {

			let decodedData = try result.decode(type: BaseResponse<T>.self, decoder: decoder)
			return decodedData
		} catch {
			print("디코딩 에러" + (String(data: result, encoding: .utf8) ?? ""))
			ErrorHandler.shared.handleAPIError(.parseError(error.localizedDescription))
			return nil
		}
		

    }
    
    // BaseResponse 없는 메소드
	public func performRequestWithoutBaseResponse<T: Decodable>(endPoint: EndPoint, decoder: DataDecoder = JSONDecoder()) async -> T? {
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

public extension APIManager {
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
		  
	  case let .uploadImagesWithParameter(images, params, imageKeyName):
		  return AF.upload(multipartFormData: { multipartFormData in
			  for image in images {
				  if let image = image {
					  multipartFormData.append(image, withName: imageKeyName, fileName: "\(image).jpeg", mimeType: "image/jpeg")
				  }
			  }
		  }, to: URL(string: "\(endPoint.baseURL)\(endPoint.path)\(queryString(from: params))")!, method: endPoint.method, headers: endPoint.headers, interceptor: AuthManager())
          
      case let .authRequestJSONEncodable(parameters):
          return AF.request(
            "\(endPoint.baseURL)\(endPoint.path)",
            method: endPoint.method,
            parameters: parameters,
            encoder: JSONParameterEncoder.default,
            headers: endPoint.headers
          )
		  
	  case .authRequestPlain:
		  return AF.request(
			"\(endPoint.baseURL)\(endPoint.path)",
			method: endPoint.method,
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
	
	func queryString(from parameters: [String: Any]) -> String {
		var components: [String] = []
		
		for (key, value) in parameters {
			if let arrayValue = value as? [Any] {
				for element in arrayValue {
					components.append("\(key)=\(element)")
				}
			} else {
				components.append("\(key)=\(value)")
			}
		}
		print(components.isEmpty ? "" : "?" + components.joined(separator: "&"))
		return components.isEmpty ? "" : "?" + components.joined(separator: "&")
	}
}

public extension APIManager {
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
