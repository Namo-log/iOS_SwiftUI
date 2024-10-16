//
//  AuthMapper.swift
//  DomainAuth
//
//  Created by 박민서 on 10/16/24.
//

import Foundation
import Core

extension SignUpCompleteResponseDTO {
    func toSignUpInfo() -> SignUpInfo {
        SignUpInfo(
            userId: userId,
            nickname: nickname,
            tag: tag,
            name: name,
            bio: bio,
            birthday: birthday,
            colorId: colorId
        )
    }
}
