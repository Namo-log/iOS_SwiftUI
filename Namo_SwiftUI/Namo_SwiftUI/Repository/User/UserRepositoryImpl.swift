//
//  UserRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 4/13/24.
//

import Foundation

final class UserRepositoryImpl: UserRepository {
    
    // 약관동의
    func registerTermsAgreement<T:Decodable>(termAgreement: TermRequest) async -> BaseResponse<T>?  {
        
        return await APIManager.shared.performRequest(endPoint: UserEndPoint.agreementTemrs(termAgreement: termAgreement))
    }
}
