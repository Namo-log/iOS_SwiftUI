//
//  PlaceInteractor.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

protocol PlaceInteractor {
    func getPlaceList(query: String) async 
    func selectPlace(place: Place?)
    func clearPlaces(isSave: Bool)
}
