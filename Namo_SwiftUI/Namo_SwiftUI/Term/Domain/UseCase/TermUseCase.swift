//
//  TermUseCase.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/2/24.
//

import Foundation

final class TermUseCase {
    
    private let termRepository: TermRepository
    
    init() {
        self.termRepository = TermRepositoryImpl()
    }
    
    func registerTermsAgreement() async {
        
        let result: BaseResponse<RegisterTermRequestDTO>? = await termRepository.registerTermsAgreement(termAgreement: RegisterTermRequestDTO(isCheckTermOfUse: true, isCheckPersonalInformationCollection: true))
        
        if result?.code == 200 {
            UserDefaults.standard.set(false, forKey: "newUser")
        }
    }
}


