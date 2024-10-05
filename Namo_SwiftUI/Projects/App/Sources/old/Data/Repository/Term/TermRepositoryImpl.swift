////
////  TermRepositoryImpl.swift
////  Namo_SwiftUI
////
////  Created by KoSungmin on 7/3/24.
////
//
//import Foundation
//
//import CoreNetwork
//
//final class TermRepositoryImpl: TermRepository {
//    
//    // 약관동의
//    func registerTermsAgreement<T:Decodable>(termAgreement: RegisterTermRequestDTO) async -> BaseResponse<T>? {
//        
//        return await APIManager.shared.performRequest(endPoint: TermEndPoint.agreementTemrs(termAgreement: termAgreement))
//    }
//}
