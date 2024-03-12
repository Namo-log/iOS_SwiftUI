//
//  ErrorHandler.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 3/13/24.
//

import Foundation
import SwiftUI
import os

class ErrorHandler {
    // Singleton
    static let shared = ErrorHandler()
    
    /// ErrorHandler에서 사용하는 Logger입니다.
    /// Error를 특정 타입의 로그로 남기는데 사용됩니다.
    private let logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: ErrorHandler.self)
        )
    
    /// Namo 앱이 현재 표시중인 Window입니다.
    /// App에 연결된 Scene들 중에서 keyWindow를 찾아 return합니다.
    private var keyWindow: UIWindow? {
        let allScenes = UIApplication.shared.connectedScenes
        for scene in allScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            for window in windowScene.windows where window.isKeyWindow {
                return window
            }
        }
        return nil
    }
    
    /// Namo 앱의 rootViewController입니다.
    /// keyWindow의 rootViewController를 받아 앱에서 사용가능한 presentedViewController를 return 합니다.
    private var rootController: UIViewController? {
        var root = keyWindow?.rootViewController
        while let presentedViewController = root?.presentedViewController {
            root = presentedViewController
        }
        return root
    }
    
    /// ErrorHandler의 에러 처리 함수입니다.
    ///
    /// - Parameters:
    ///   - type: 에러가 처리되는 타입입니다. `.ignore`의 경우 UI표시 없이, `.showAlert`의 경우 UI표시와 함께 처리됩니다.
    ///   - error:에러의 타입입니다. 에러가 표시될 내용을 결정합니다. `localizeDescription`으로 시스템 로그에 남길 description을 작성합니다.
    ///   - primaryAction: Alert에 추가될 버튼+action 입니다. `UIAlertAction`타입을 통해 작성합니다. 배열로 추가하여 여러 버튼을 작성 가능합니다. 미사용시 "확인" 기본 버튼이 작성됩니다.
    func handle(type: ErrorHandlingType, error: AppError, actions: [UIAlertAction]? = nil) {
        // 에러 처리 타입에 따라 로그 앞 Emoji 추가
        var errorTypeEmoji: String {
            switch type {
            case .ignore:
                return "⚠️ IgnoreTypeError Occured"
            case .showAlert:
                return "⚠️👀 ShowAlertError Occured"
            }
        }
        
        // 에러 로그 출력
        self.logger.error("\(errorTypeEmoji) : \(error.localizedDescription)")
        
        // UI 표시가 동반되는 에러인 경우
        if type == .showAlert {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: error.content.title, message: error.content.message, preferredStyle: .alert)
                
                // actions 작성하지 않은 경우 "확인" 버튼이 디폴트로 작성됨
                guard let actions = actions else {
                    let primary = UIAlertAction(title: "확인", style: .default)
                    alertController.addAction(primary)
                    self.rootController?.present(alertController, animated: true)
                    return
                }
                
                // alert에 action 추가
                actions.forEach { action in
                    alertController.addAction(action)
                }
                
                // 현재 앱에 표시된 ViewController에 alertController 표시
                self.rootController?.present(alertController, animated: true)
            }
        }
    }
    
    
    /// ErrorHandler의 API 에러 처리 함수입니다.
    ///
    /// - Parameters:
    ///   - error: API 통신 도중 발생되는 error 타입입니다. error description에 해당 타입에 따라 추가 정보가 작성됩니다.
    func handleAPIError(_ error: APIError) {

        var description: String = ""
        
        switch error {
        case .networkError:
            description = "네트워크 에러입니다. 이유 불명"
        case .badRequest(let string):
            description = "잘못된 요청 : \(String(describing: string))"
        case .serverError(let string):
            description = "서버 내부 에러 : \(String(describing: string))"
        case .parseError(let string):
            description = "디코딩 에러 : \(string ?? "")"
        case .unknown:
            description = "알 수 없는 에러"
        case .customError(let string):
            description = string
        }
        
        // UI에 표시하는 에러로 컨버팅하여 진행합니다.
        self.handle(type: .showAlert, error: .networkError(localizedDescription: description))
    }
}
