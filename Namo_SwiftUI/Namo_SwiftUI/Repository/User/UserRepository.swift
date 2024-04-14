//
//  UserRepository.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 4/13/24.
//

import Foundation

protocol UserRepository {
    
    // 약관동의
    func registerTermsAgreement<T:Decodable>(termAgreement: TermRequest) async -> BaseResponse<T>?
}
