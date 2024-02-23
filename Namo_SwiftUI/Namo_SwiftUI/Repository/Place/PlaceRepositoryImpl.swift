//
//  PlaceRepositoryImpl.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/23/24.
//

final class PlaceRepositoryImpl: PlaceRepository {
    
    /// KakaoMapRESTAPI를 통해 입력 쿼리에 해당하는 결과를 가져옵니다.
    func getKakaoMapPlaces(query:String) async -> [Place] {
        let result: KakaoMapResponseDTO? = await APIManager.shared.performRequest(endPoint: ScheduleEndPoint.getAllSchedule)
        
        return result?.documents.map { $0.toPlace() } ?? []
    }
}
