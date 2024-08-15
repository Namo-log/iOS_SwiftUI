//
//  Environment.swift
//  EnvPlugin
//
//  Created by 정현우 on 8/15/24.
//

import ProjectDescription

public enum Environment {
	public static let workspaceName = "Namo_SwiftUI"
}

public extension Project {
	enum Environment {
		public static let workspaceName = "Namo_SwiftUI"
		public static let deploymentTarget = DeploymentTargets.iOS("16.0")
		public static let platform = Platform.iOS
		public static let bundlePrefix = "com.mongmong.namo"
	}
}

