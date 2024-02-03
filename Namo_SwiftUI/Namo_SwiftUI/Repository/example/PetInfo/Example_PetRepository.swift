//
//  PetRepository.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

protocol Example_PetRepository {
    /// 지정된 ID에 해당하는 반려동물 데이터를 가져옵니다.
    ///
    /// - Parameters:
    ///     - `id`: 가져올 반려동물의 ID
    /// - Returns: `getPetInfoResponseModel` 타입의 결과 데이터
    func fetchPetInfo(id: Int) async -> getPetInfoResponseModel?
    
    /// 모든 반려동물의 목록을 가져옵니다.
    ///
    /// - Returns: `getAllPetsResponseModel` 타입의 결과 데이터
    func fetchAllPetInfo() async -> getAllPetsResponseModel?
    
    /// 주어진 데이터를 사용하여 새로운 반려동물 정보를 서버에 등록하고, 결과를 반환합니다.
    ///
    /// - Parameters:
    ///     - `id`: 등록할 반려동물의 ID
    ///     - `dto`: 등록할 반려동물 데이터 (`postPetInfoUpdateRequestModel` 타입)
    /// - Returns: `postPetInfoUpdateResponseModel` 타입의 결과 데이터
    func updatePetInfo(id: Int, dto: postPetInfoUpdateRequestModel) async -> postPetInfoUpdateResponseModel?
    
    /// 특정 반려동물을 삭제합니다.
    ///
    /// - Parameters:
    ///     - `id`: 삭제할 반려동물의 ID
    /// - Returns: `deletePetResponseModel` 타입의 결과 데이터
    func deletePetInfo(id: Int) async -> deletePetResponseModel?
}
