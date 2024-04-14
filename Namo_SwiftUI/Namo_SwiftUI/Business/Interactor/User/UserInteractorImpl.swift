//
//  UserInteractorImpl.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 4/13/24.
//

import Foundation
import Factory

struct UserInteractorImpl: UserInteractor {
    
    @Injected(\.userRepository) private var userRepository
    
    // 약관동의
    func registerTermsAgreement() async {
        
        let result: BaseResponse<TermRequest>? = await userRepository.registerTermsAgreement(termAgreement: TermRequest(isCheckTermOfUse: true, isCheckPersonalInformationCollection: true))
        
        // 약관동의가 정상처리 되었을 때만
        if result?.code == 200 {
            UserDefaults.standard.set(false, forKey: "newUser")
        }
    }
}
