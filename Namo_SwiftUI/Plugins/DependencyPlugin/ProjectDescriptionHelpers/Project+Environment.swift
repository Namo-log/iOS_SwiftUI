//
//  Project+Environment.swift
//  DependencyPlugin
//
//  Created by 정현우 on 8/20/24.
//

import Foundation
import ProjectDescription

public extension Project {
	enum Environment {
		public static let appName = "Namo_SwiftUI"
		public static let deploymentTarget = DeploymentTargets.iOS("16.0")
		public static let bundlePrefix = "com.mongmong.namo"
		
	}
}
