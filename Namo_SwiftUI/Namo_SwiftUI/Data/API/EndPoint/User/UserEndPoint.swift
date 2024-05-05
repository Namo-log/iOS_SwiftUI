//
//  UserEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 4/13/24.
//

import Foundation
import Alamofire

enum UserEndPoint {
    
    // 약관 동의
    case agreementTemrs(termAgreement: TermRequest)
}

extension UserEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(SecretConstants.baseURL)"
    }
    
    var path: String {
        
        switch self {
            
        case .agreementTemrs:
            return "/term"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .agreementTemrs:
            return .post
        }
    }
    
    var task: APITask {
        
        switch self {
        case .agreementTemrs(termAgreement: let dto):
            return .requestJSONEncodable(parameters: dto)
        }
    }
}
