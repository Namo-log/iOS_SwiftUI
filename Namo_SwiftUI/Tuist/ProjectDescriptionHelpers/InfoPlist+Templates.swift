//
//  InfoPlist+Templates.swift
//  AppManifests
//
//  Created by 정현우 on 9/1/24.
//

import ProjectDescription

public extension InfoPlist {
	static let exampleAppDefault: InfoPlist = .extendingDefault(
		with: [
			"CFBundleShortVersionString": "1.0",
			"CFBundleVersion": "1",
			"UILaunchStoryboardName": "LaunchScreen",
			"UIApplicationSceneManifest": [
				"UIApplicationSupportsMultipleScenes": false,
				"UISceneConfigurations": []
			]
		])
}
