//
//  AuthClient.swift
//  DomainAuthInterface
//
//  Created by 박민서 on 9/18/24.
//

import Foundation
import ComposableArchitecture

import Core
import DomainAuthInterface
import SharedUtil

/// API를 통해 소셜 로그인과 로그아웃, 나모 인증 작업을 수행하는 역할을 담당합니다.
/// Auth 관련 Namo API는 모두 이곳에서 호출됩니다.
/// - 의존성:
///   - `SNSLoginHelperProtocol`을 사용하여 소셜 로그인/로그아웃 API 로직을 처리합니다.
///   - 서버와의 통신을 담당하는 `APIManager`를 통해 실제 로그아웃 API 요청을 수행합니다.
extension AuthClient: DependencyKey {
    public static let liveValue = AuthClient(
        
        // MARK: API
        loginHelper: SNSLoginHelper(),
        authManager: AuthManager(),
        reqSignInWithApple: { reqDTO -> SignInResponseDTO in
            let res: BaseResponse<SignInResponseDTO> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInApple(appleToken: reqDTO))
            guard let data = res.result else {
                throw APIError.parseError("res.result is nil")
            }
            return data
        },
        reqSignInWithNaver: { reqDTO -> SignInResponseDTO in
            let res: BaseResponse<SignInResponseDTO> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInNaver(naverToken: reqDTO))
            guard let data = res.result else {
                throw APIError.parseError("res.result is nil")
            }
            return data
        },
        reqSignInWithKakao: { reqDTO -> SignInResponseDTO in
            let res: BaseResponse<SignInResponseDTO> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.signInKakao(kakaoToken: reqDTO))
            guard let data = res.result else {
                throw APIError.parseError("res.result is nil")
            }
            return data
        },
        reqSignOut: { reqDTO -> Void in
            let result: BaseResponse<String> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.logout(refreshToken: reqDTO))
            // 나모 로그아웃 요청이 실패한 경우 에러 throw
            if result.code != 200 {
                throw APIError.customError("로그아웃 실패: 응답 코드 \(result.code)")
            }
        },
        reqWithdrawalApple: { reqDTO in
            let result: BaseResponse<String> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: reqDTO))
            
            if result.code != 200 {
                throw APIError.customError("회원 탈퇴 실패: 응답 코드 \(result.code)")
            }
        },
        reqWithdrawalNaver: { reqDTO in
            let result: BaseResponse<String> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: reqDTO))
            
            if result.code != 200 {
                throw APIError.customError("회원 탈퇴 실패: 응답 코드 \(result.code)")
            }
        },
        reqWithdrawalKakao: { reqDTO in
            let result: BaseResponse<String> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.withdrawMemberApple(refreshToken: reqDTO))
            
            if result.code != 200 {
                throw APIError.customError("회원 탈퇴 실패: 응답 코드 \(result.code)")
            }
        },
        reqTermsAgreement: { reqDTO in
            let result: BaseResponse<String> = try await APIManager.shared.performRequest(endPoint: TermEndPoint.agreementTemrs(termAgreement: reqDTO))
            
            if result.code != 200 {
                throw APIError.customError("약관 동의 실패: 응답 코드 \(result.code)")
            }
        },
        reqProfileImageUpload: { reqImg in
            guard let imageFile = reqImg.resize(newWidth: 55).jpegData(compressionQuality: 0.6) else { throw NSError(domain: "이미지 압축 에러", code: 1001) }
            
            let filename = "profile_image_\(Int(Date().timeIntervalSince1970))_\(UUID().uuidString)"
            guard let url = try await APIManager.shared.getPresignedUrl(prefix: "profile", filename: filename).result else { throw APIError.customError("s3 getPresignedUrl 에러") }
            
            guard let uploadedUrl = try await APIManager.shared.uploadImageToS3(presignedUrl: url, imageFile: imageFile) else { throw APIError.customError("s3 uploadImageToS3 에러") }
            
            return uploadedUrl
        },
        reqSignUpComplete: { reqDTO in
            let result: BaseResponse<SignUpCompleteResponseDTO> = try await APIManager.shared.performRequest(endPoint: AuthEndPoint.signUpComplete(signUpInfo: reqDTO))
            
            if result.code != 200 {
                throw APIError.customError("회원 가입 완료 실패: 응답 코드 \(result.code)")
            }
            
            guard let data = result.result else {
                throw APIError.parseError("result.result is nil")
            }
            return data.toSignUpInfo()
        }
    )
}

extension DependencyValues {
    public var authClient: AuthClient {
        get { self[AuthClient.self] }
        set { self[AuthClient.self] = newValue }
    }
}

