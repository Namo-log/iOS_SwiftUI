//
//  LoginViewModel.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/23/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    // true면 prod 서버, false면 dev 서버
    static let isProd: Bool = false
    static let namoUrl = isProd ? "http://www.namoserver.shop/prod" : "https://www.namoserver.shop"
    
}
