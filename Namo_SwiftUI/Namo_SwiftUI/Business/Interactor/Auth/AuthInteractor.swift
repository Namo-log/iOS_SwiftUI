//
//  AuthInteractor.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 2/4/24.
//

import Foundation

// 예시로 넣어둔 Interactor 프로토콜이며 실제 구현에 쓰일 예정입니다.
// 추후 테스트 코드 작성시 테스트용 구현체가 추가될 예정입니다.
protocol AuthInteractor {
    
    // 카카오 로그인
    func kakaoLogin() async
    // 로그아웃
    func logout() async
    
    // 예시로 쓰인 메소드입니다.
    func example()
}
