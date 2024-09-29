//
//  AlertView.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 6/26/24.
//

import SwiftUI

enum AlertType {
	case alertWithTitleAndMessage(
		title: String,
		message: String? = nil,
		leftButtonTitle: String?,
		leftButtonAction: () -> Void = {},
		rightButtonTitle: String,
		rightButtonAction: () -> Void
	)
	case alertWithTopButton(
		title: String,
		leftButtonTitle: String,
		leftButtonAction: () -> Void,
		rightButtonTitle: String,
		rightButtonAction: () -> Void,
		content: AnyView
	)
	case alertWithContent(
		content: AnyView,
		leftButtonTitle: String? = nil,
		leftButtonAction: () -> Void = {},
		rightButtonTitle: String,
		rightButtonAction: () -> Void
	)
}

struct NamoAlertView: View {
	@EnvironmentObject var appState: AppState
	
	var body: some View {
		ZStack {
			if let alertType = appState.alertType {
				switch alertType {
				case let .alertWithTitleAndMessage(title, message, leftButtonTitle, leftButtonAction, rightButtonTitle, rightButtonAction):
					AlertViewWithTitleAndMessage(
						showAlert: $appState.alertType,
						title: title,
						message: message,
						leftButtonTitle: leftButtonTitle,
						leftButtonAction: leftButtonAction,
						rightButtonTitle: rightButtonTitle,
						rightButtonAction: rightButtonAction
					)
					
				case let .alertWithTopButton(title, leftButtonTitle, leftButtonAction, rightButtonTitle, rightButtonAction, content):
					AlertViewWithTopButton(
						showAlert: $appState.alertType,
						title: title,
						leftButtonTitle: leftButtonTitle,
						leftButtonAction: leftButtonAction,
						rightButtonTitle: rightButtonTitle,
						rightButtonAction: rightButtonAction,
						content: content
					)
					
				case let .alertWithContent(content, leftButtonTitle, leftButtonAction, rightButtonTitle, rightButtonAction):
					AlertViewWithContent(
						showAlert: $appState.alertType,
						content: content,
						leftButtonTitle: leftButtonTitle,
						leftButtonAction: leftButtonAction,
						rightButtonTitle: rightButtonTitle,
						rightButtonAction: rightButtonAction
					)
				}
			} else if let alertType = appState.secondaryAlertType {
				switch alertType {
				case let .alertWithTitleAndMessage(title, message, leftButtonTitle, leftButtonAction, rightButtonTitle, rightButtonAction):
					AlertViewWithTitleAndMessage(
						showAlert: $appState.secondaryAlertType,
						title: title,
						message: message,
						leftButtonTitle: leftButtonTitle,
						leftButtonAction: leftButtonAction,
						rightButtonTitle: rightButtonTitle,
						rightButtonAction: rightButtonAction
					)
					
				case let .alertWithTopButton(title, leftButtonTitle, leftButtonAction, rightButtonTitle, rightButtonAction, content):
					AlertViewWithTopButton(
						showAlert: $appState.secondaryAlertType,
						title: title,
						leftButtonTitle: leftButtonTitle,
						leftButtonAction: leftButtonAction,
						rightButtonTitle: rightButtonTitle,
						rightButtonAction: rightButtonAction,
						content: content
					)
					
				case let .alertWithContent(content, leftButtonTitle, leftButtonAction, rightButtonTitle, rightButtonAction):
					AlertViewWithContent(
						showAlert: $appState.secondaryAlertType,
						content: content,
						leftButtonTitle: leftButtonTitle,
						leftButtonAction: leftButtonAction,
						rightButtonTitle: rightButtonTitle,
						rightButtonAction: rightButtonAction
					)
				}
			}
		}
	}
}

#Preview {
	NamoAlertView()
}
