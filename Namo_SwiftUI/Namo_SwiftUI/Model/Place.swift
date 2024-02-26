//
//  Placve.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/8/24.
//

/// 일정 장소에 사용되는 모델입니다.
struct Place {
    /// id입니다. - KakaoMap 기준
    let id: Int
    /// 경도입니다 : longitude
    let x: Double
    /// 위도입니다 : latitude
    let y: Double
    /// 장소 이름입니다.
    let name: String
    /// 지번 주소입니다.
    let address: String
    /// 도로명 주소입니다.
    let rodeAddress: String
    /// 선택되었는지
    let isSelected: Bool = false
}
