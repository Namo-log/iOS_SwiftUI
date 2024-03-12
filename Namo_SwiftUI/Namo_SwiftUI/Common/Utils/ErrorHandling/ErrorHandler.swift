//
//  ErrorHandler.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 3/13/24.
//

import Foundation
import SwiftUI

class ErrorHandler {
    // Singleton
    static let shared = ErrorHandler()
    
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
    ///   - primaryAction: 첫번째 버튼에 사용할 Action입니다. `UIAlertAction`타입을 통해 작성합니다.
    ///   - secondaryAction: 두번째 버튼에 사용할 Action입니다. primaryAction 없이 사용하지 않습니다.`UIAlertAction`타입을 통해 작성합니다.
    func handle(type: ErrorHandlingType, error: AppError, primaryAction: UIAlertAction? = nil, secondaryAction: UIAlertAction? = nil) {
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
        print("\(errorTypeEmoji) : \(error.localizedDescription)")
        
        // UI 표시가 동반되는 에러인 경우
        if type == .showAlert {
            DispatchQueue.main.async {
                let alertController = UIAlertController(title: error.content.title, message: error.content.message, preferredStyle: .alert)
                // primary 작성하지 않은 경우 "확인" 버튼이 디폴트로 작성됨
                let primary = primaryAction ?? UIAlertAction(title: "확인", style: .default)
                alertController.addAction(primary)
                
                if let secondary = secondaryAction {
                    alertController.addAction(secondary)
                }
                // 현재 앱에 표시된 ViewController에 alertController 표시
                self.rootController?.present(alertController, animated: true)
            }
        }
    }
}
