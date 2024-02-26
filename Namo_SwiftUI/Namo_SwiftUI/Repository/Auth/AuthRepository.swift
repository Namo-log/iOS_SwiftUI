//
//  AuthRepository.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

import Foundation

// 예시로 넣어둔 AuthRepository 프로토콜이며 실제 구현에 쓰일 예정입니다.
// 추후 테스트 코드 작성시 테스트용 구현체가 추가될 예정입니다.
protocol AuthRepository {
    
    // 카카오, 네이버 소셜 로그인. 서버로부터 토큰을 발급받는 메소드
    func getServerToken(socialAccessToken: SocialAccessToken, social: String) async -> Auth?
    
    // 로그아웃. 토큰 삭제
    func removeToken<T:Decodable>(serverAccessToken: ServerAccessToken) async -> BaseResponse<T>?
}
