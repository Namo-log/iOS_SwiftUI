//
//  postPetInfoDTO.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//

struct postPetInfoUpdateRequestModel: Encodable {
    let pet_id: Int
    let pet_name: String
    let profile_image: String?
    let status: String?
}

struct postPetInfoUpdateResponseModel: Decodable {
    let pet_id: Int
    let pet_name: String
    let profile_image: String?
    let status: String?
}
