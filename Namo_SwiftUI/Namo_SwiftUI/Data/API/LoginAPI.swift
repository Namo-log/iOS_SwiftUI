//
//  LoginAPI.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/24/24.
//

import Foundation
import Alamofire

struct LoginResponse: Decodable {
    
    let code: Int
    let message: String
    let result: LoginModel?
}

struct LoginModel: Decodable {
    let accessToken: String
    let refreshToken: String
}

class LoginAPI {
    
    // true면 prod 서버, false면 dev 서버
    static var isProd: Bool = false
    static let namoUrl = isProd ? "http://www.namoserver.shop/prod" : "https://www.namoserver.shop"
    
    public static func kakaoLogin(accessToken: String, completion: @escaping ((Result<LoginResponse, AFError>) -> Void)) {
        
        let url = "\(LoginAPI.namoUrl)/auth/kakao/signup"
        
        let body: [String: Any] = [
            
            "accessToken": accessToken
        ]
        
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: LoginResponse.self) { response in
                
                switch response.result {
                    
                case.success(let result):

                    if (result.code == 200) {
                        completion(response.result)
                    } else {
                        print("실패(카카오 로그인): \(result.message)")
                        completion(response.result)
                    }
                case .failure(let error):
                    completion(response.result)
                    print("실패(AF-카카오 로그인: \(error.localizedDescription)")
            }
    }
    
//    static func kakaoLogin(accessToken: String) async throws {
//        
//        let url = "\(LoginAPI.namoUrl)/auth/kakao/signup"
//        
//        let httpBody: [String: String] = ["accessToken": accessToken]
//        
//        AF.request(url, method: .post, parameters: httpBody, encoding: JSONEncoding.default)
//            .validate()
//            .responseDecodable(of: LoginResponse.self) { response in
//                
//                switch response.result {
//                
//                case.success(let result):
//                    
//                    do {
//                        try KeyChainManager.addItem(key: "accessToken", value: result.result?.accessToken ?? "11")
//                    } catch {
//                        throw KeyChainError.itemNotFound
//                    }
//
//                case .failure(_):
//                    <#code#>
//                }
//        
//        
////        let request = AF.request(url, method: .post, parameters: httpBody, encoding: JSONEncoding.default)
////    
////        let response = try await request.serializingDecodable(LoginResponse.self).value
////        
////        do {
////            try KeyChainManager.addItem(key: "accessToken", value: response.result?.accessToken ?? "")
////            try KeyChainManager.addItem(key: "refreshToken", value: response.result?.refreshToken ?? "")
////
////        } catch KeyChainError.invalidItemFormat {
////
////            throw KeyChainError.invalidItemFormat
////            
////        } catch (let error) {
////
////            throw error
////        }
    }
    
}
