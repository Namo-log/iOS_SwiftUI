//
//  AuthManager.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 1/30/24.
//

import Alamofire
import Foundation
import Factory
import NaverThirdPartyLogin

/// API Request의 Authentication을 관리합니다.
class AuthManager: RequestInterceptor {
    
    @Injected(\.appState) private var appState: AppState
    
    /// 요청 실패 시 재시도 횟수입니다.
    private var retryLimit = 2
    
    /// URLRequest를 보내는 과정을 Intercept하여, Request의 내용을 변경합니다.
    ///
    /// - Parameters:
    ///    - urlRequest: 원래의 URLRequest
    ///    - session : 진행하는 Alamofire Session
    ///    - completion: 변경된 URLRequest를 포함하는 Result를 비동기 처리하는 클로저
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        // baseURL 확인
        guard urlRequest.url?.absoluteString.hasPrefix(SecretConstants.baseURL) == true else { return }
        
        // accessToken 조회
        guard let accessToken = KeyChainManager.readItem(key: "accessToken") else {
            
            // 토큰이 없는 경우 isLogin = false -> 로그인 화면으로 이동
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
                NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
            }
            
            completion(.failure(APIError.customError("키체인 토큰 조회 실패. 로그인이 필요합니다.")))
            return
        }
        
        //: 조건 확인 끝
        
        // URLRequest 헤더 추가, return
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization("Bearer \(accessToken)"))
		print(urlRequest.headers)
        print("JWT: \(accessToken)")
        
        completion(.success(urlRequest))
    }
    
    /// Request 요청이 실패했을 때, 재시도 여부를 결정합니다.
    ///
    /// - Parameters:
    ///     - request: 실패한 원래 Request
    ///     - session: 진행하던 Alamofire Session
    ///     - error: 실패 원인의 error
    ///     - completion: RetryResult를 처리하여 재시도 여부를 알려주는 비동기 클로저
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        // HTTP 응답 코드 확인, 재시도 여부 결정
        guard let response = request.task?.response as? HTTPURLResponse,
              response.statusCode == 401 || response.statusCode == 403 || response.statusCode == 404 else {
            // 401 Unauthorized 또는 403 Forbidden 상태 코드가 아니라면, Error 메세지와 함께 재시도하지 않음
            completion(.doNotRetryWithError(error))
            return
        }
        
        // 해당 경로로 accessToken 재발급 요청
        guard let url = URL(string: SecretConstants.baseURL+"/auths/reissuance") else { return }
        
        guard let accessToken = KeyChainManager.readItem(key: "accessToken"),
              let refreshToken = KeyChainManager.readItem(key: "refreshToken")
        else {
            
            // 토큰 없는 경우 에러 처리
            
            // 토큰이 없는 경우 isLogin = false -> 로그인 화면으로 이동
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
                NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
            }
            
            // 이것처럼 처리도 가능
            completion(.doNotRetryWithError(APIError.customError("키체인 토큰 조회 실패. 로그인이 필요합니다.")))
            return
        }
        
        // 여기는 대충 AF Req 생성 과정임
        let parameters: Parameters = [
            "accessToken": accessToken,
            "refreshToken": refreshToken
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default)
        .validate()
        .responseDecodable(of: ServerTokenResponse.self) { response in
            switch response.result {
            
            // 재발급 성공
            case .success(let result):
                
                // 재발급된 토큰을 키체인에 저장
                KeyChainManager.addItem(key: "accessToken", value: result.accessToken)
                KeyChainManager.addItem(key: "refreshToken", value: result.refreshToken)
                
                // 기존에 보내고자 했던 요청 재시도
                // 재시도 횟수 내일 때만 재시도
                request.retryCount < self.retryLimit ?
                completion(.retry) : completion(.doNotRetry)
//                completion(.retry) : completion(.doNotRetryWithError(APIError.customError("재시도 횟수 초과"))) //
                
            // 재발급 실패(refreshToken 만료)
            case .failure(let error):
                // 토큰 갱신 실패 시 에러 처리
                print(error)
                
                // 로그인 화면으로 이동
                DispatchQueue.main.async {
                    UserDefaults.standard.set(false, forKey: "isLogin")
                    NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
                }
                
                // 이것도 가능
                completion(.doNotRetryWithError(error))
                print("토큰 갱신 에러. 로그인 필요")
            }
        }
    }
}
