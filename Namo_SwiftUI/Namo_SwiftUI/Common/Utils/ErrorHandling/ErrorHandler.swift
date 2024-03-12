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
    
    
}
