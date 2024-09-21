//
//  PlaceRepositor.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

import CoreNetwork

protocol PlaceRepository {
    func getKakaoMapPlaces(query:String) async -> KakaoMapResponseDTO?
}
