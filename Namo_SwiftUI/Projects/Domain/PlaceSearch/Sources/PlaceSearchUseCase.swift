//
//  PlaceSearchUseCase.swift
//  DomainPlaceSearch
//
//  Created by 권석기 on 10/20/24.
//

import Foundation
import ComposableArchitecture
import DomainPlaceSearchInterface

extension PlaceSearchUseCase: DependencyKey {
    public static var liveValue: PlaceSearchUseCase = PlaceSearchUseCase { query in
        print("검색어: ", query)
    }
}

extension DependencyValues {
    public var placeUseCase: PlaceSearchUseCase {
        get { self[PlaceSearchUseCase.self] }
        set { self[PlaceSearchUseCase.self] = newValue }
    }
}
