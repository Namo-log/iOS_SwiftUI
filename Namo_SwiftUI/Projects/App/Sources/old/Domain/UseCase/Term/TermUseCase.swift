////
////  TermUseCase.swift
////  Namo_SwiftUI
////
////  Created by KoSungmin on 7/2/24.
////
//
//import Foundation
//import Factory
//
//import CoreNetwork
//
//final class TermUseCase {
//    
//    static let shared = TermUseCase()
//
//    @Injected(\.termRepository) var termRepository
//    
//    func registerTermsAgreement() async {
//        
//        let result: BaseResponse<RegisterTermRequestDTO>? = await termRepository.registerTermsAgreement(termAgreement: RegisterTermRequestDTO(isCheckTermOfUse: true, isCheckPersonalInformationCollection: true))
//        
//        if result?.code == 200 {
//            UserDefaults.standard.set(false, forKey: "newUser")
//        }
//    }
//}
//
//
