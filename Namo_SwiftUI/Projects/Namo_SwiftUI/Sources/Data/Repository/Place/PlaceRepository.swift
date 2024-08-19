//
//  PlaceRepositor.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

import Networks

protocol PlaceRepository {
    func getKakaoMapPlaces(query:String) async -> KakaoMapResponseDTO?
}
