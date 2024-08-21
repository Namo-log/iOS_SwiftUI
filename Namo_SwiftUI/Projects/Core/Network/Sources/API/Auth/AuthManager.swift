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

import SharedUtil

/// API Request의 Authentication을 관리합니다.
public class AuthManager: RequestInterceptor {
    
    /// 요청 실패 시 재시도 횟수입니다.
    private var retryLimit = 2
    
    /// URLRequest를 보내는 과정을 Intercept하여, Request의 내용을 변경합니다.
    ///
    /// - Parameters:
    ///    - urlRequest: 원래의 URLRequest
    ///    - session : 진행하는 Alamofire Session
    ///    - completion: 변경된 URLRequest를 포함하는 Result를 비동기 처리하는 클로저
	public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        
        // baseURL 확인
        guard urlRequest.url?.absoluteString.hasPrefix(SecretConstants.baseURL) == true else { return }
        
        // accessToken 조회
        guard let accessToken = KeyChainManager.readItem(key: "accessToken") else {
            
            // 토큰이 없는 경우 isLogin = false -> 로그인 화면으로 이동
            DispatchQueue.main.async {
                UserDefaults.standard.set(false, forKey: "isLogin")
                NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
            }
            
            completion(.failure(APIError.customError("[AuthManager] 키체인 토큰 조회 실패. 로그인이 필요합니다. (adapt)")))
            return
        }
        
        //: 조건 확인 끝
        
        // URLRequest 헤더 추가, return
        var urlRequest = urlRequest
        urlRequest.headers.add(.authorization("Bearer \(accessToken)"))
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
	public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        print("=======retry 호출됨========")
        
        if request.retryCount < self.retryLimit {
            
            print("기존 요청 재시도")
            
            completion(.retry)
        } else {
            
            // 네트워크 오류. 잠시 후 다시 시도해달라는 Alert 창을 띄움
            ErrorHandler.shared.handleAPIError(.networkError)
            
            completion(.doNotRetry)
        }
        
    }
}
