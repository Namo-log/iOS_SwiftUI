//
//  ex_PetEndPoint.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/3/24.
//


import Alamofire
import Foundation

/// Pet 관련 네트워크 요청 시 사용하는 통신 케이스를 정의한 열거형입니다.
enum Example_PetEndPoint {
    /// 지정된 ID에 해당하는 반려동물 데이터를 가져옵니다.
    case getPetInfo(id: Int)
    /// 모든 반려동물의 목록을 가져옵니다.
    case getAllPets
    /// 새로운 반려동물 정보를 서버에 등록하고, 등록 결과를 가져옵니다.
    case postPetInfoUpdate(id: Int, dto: postPetInfoUpdateRequestModel)
    /// 특정 반려동물을 삭제합니다.
    case deletePet(id: Int)
}

extension Example_PetEndPoint: EndPoint {
    
    var baseURL: String {
        return "\(SecretConstants.baseURL)/pet"
    }
    
    var path: String {
        switch self {
            
        case let .getPetInfo(id):
            return "/info/\(id)"
        case .getAllPets:
            return "/info/all"
        case let .postPetInfoUpdate(id, _):
            return "/info/\(id)/update"
        case .deletePet:
            return "/delete"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        
        case .getPetInfo, .getAllPets:
            return .get
        case .postPetInfoUpdate:
            return  .post
        case .deletePet:
            return .delete
        }
    }
    
    var task: APITask {
        switch self {
        case .getPetInfo, .getAllPets:
            return .requestPlain
        case let .postPetInfoUpdate(_, dto):
            return .requestJSONEncodable(parameters: dto)
        case let .deletePet(id):
            let params = [
                "pet_id":id
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
}
