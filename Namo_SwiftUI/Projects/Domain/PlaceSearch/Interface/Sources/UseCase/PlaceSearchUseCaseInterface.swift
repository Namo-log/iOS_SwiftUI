//
//  PlaceSearchUseCaseInterface.swift
//  DomainPlaceSearch
//
//  Created by 권석기 on 10/20/24.
//

import Foundation

public struct PlaceSearchUseCase {
    public var getSearchList: @Sendable (String) async throws -> Void
    public init(getSearchList: @escaping @Sendable (_ query: String) async throws -> Void) {
        self.getSearchList = getSearchList
    }
}
