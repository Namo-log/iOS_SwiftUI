//
//  ErrorHandler.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 2/6/24.
//

import Foundation
import Factory

class ErrorHandler {
	static let shared = ErrorHandler()
	@Injected(\.appState) var appState
	
	func handleAPIError(_ error: APIError) {
		DispatchQueue.main.async { 
			switch error {
			case .networkError:
				self.appState.alertMessage = "네트워크 에러입니다."
				self.appState.showAlert = true
			case .badRequest(let string):
				print("잘못된 요청: \(String(describing: string))")
			case .serverError(let string):
				self.appState.alertMessage = "서버 에러입니다."
				self.appState.showAlert = true
			case .parseError(let string):
				print("디코딩 에러: \(string ?? "")")
			case .unknown:
				self.appState.alertMessage = "알 수 없는 에러"
				self.appState.showAlert = true
			case .customError(let string):
				self.appState.alertMessage = string
				self.appState.showAlert = true
			}
		}
	}
}
