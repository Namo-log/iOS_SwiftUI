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
    
    // 회원 탈퇴
    func withdrawMember() async
    
    // 로그아웃
    func logout() async
}
