//
//  NavigationBarBackground.swift
//  Namo_SwiftUI
//
//  Created by KoSungmin on 7/4/24.
//

import Foundation
import SwiftUI

/// 네비게이션바의 배경색을 지정할 수 있는 구조체입니다.

// 사용법: .background(CustomNavigationBar(backgroundColor: UIColor.white))

public struct CustomNavigationBar: UIViewControllerRepresentable {
	public init(backgroundColor: UIColor) {
		self.backgroundColor = backgroundColor
	}
	
    
    var backgroundColor: UIColor

	public func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        return viewController
    }

	public func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = backgroundColor
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                if let navigationController = uiViewController.navigationController {
                    navigationController.navigationBar.standardAppearance = appearance
                    navigationController.navigationBar.scrollEdgeAppearance = appearance
                }
    }
}
