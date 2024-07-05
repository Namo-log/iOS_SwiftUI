//
//  TermEndPoint.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/3/24.
//

import Foundation
import Alamofire

enum TermEndPoint {
    
    // 약관 동의
    case agreementTemrs(termAgreement: RegisterTermRequestDTO)
}

extension TermEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(SecretConstants.baseURL)"
    }
    
    var path: String {
        
        switch self {
            
        case .agreementTemrs:
            return "/terms"
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
