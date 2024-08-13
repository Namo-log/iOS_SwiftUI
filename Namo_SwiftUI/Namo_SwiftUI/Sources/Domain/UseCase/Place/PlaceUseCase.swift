//
//  PlaceUseCase.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

import Factory
import SwiftUI

final class PlaceUseCase {
	static let shared = PlaceUseCase()
    @Injected(\.placeRepository) private var placeRepository
    
    /// KakaoMapAPI를 통해 해당 쿼리에 맞는 결과를 placeList에 페칭합니다.
    func fetchPlaceList(query: String) async {
        let result = await placeRepository.getKakaoMapPlaces(query: query)
        DispatchQueue.main.async {
			AppState.shared.placeState.placeList = result?.documents.map { $0.toPlace() } ?? []
        }
    }
    
    /// KakaoMapAPI를 통해 해당 쿼리에 맞는 결과를 list로 반환합니다.
    func getPlaceList(query: String) async -> [Place]?  {
        let result = await placeRepository.getKakaoMapPlaces(query: query)
        return result?.documents.map { $0.toPlace() }
    }
    
    /// placeState의 selectPlace를 새로운 place로 변경합니다.
    func selectPlace(place: Place?) {
		AppState.shared.placeState.selectedPlace = place
		print("place 변경 : \(String(describing: AppState.shared.placeState.selectedPlace))")
    }
    
    /// placeState의 placeList를 비웁니다.
    /// save 옵션이 true면 selectedPlace만 placeList에 저장합니다.
    func clearPlaces(isSave: Bool = false) {
		if isSave, let selectedPlace = AppState.shared.placeState.selectedPlace {
			AppState.shared.placeState.placeList = [selectedPlace]
        } else {
			AppState.shared.placeState.placeList = []
        }
    }
    
    /// placeState.placeList에 새로운 place를 추가합니다.
    func appendPlaceList(place: Place) {
		AppState.shared.placeState.placeList.append(place)
        self.selectPlace(place: place)
    }
    
}

