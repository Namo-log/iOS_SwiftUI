//
//  AuthInteractor.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

protocol AuthInteractor {
    
    // 카카오 로그인
    func kakaoLogin() async
    
    // 네이버 로그인
    func naverLogin()
    
    // 애플 로그인
    func appleLogin()
    
    // 로그아웃
    func logout() async
}
