//
//  SettingsDictionary+.swift
//  EnvPlugin
//
//  Created by 정현우 on 8/17/24.
//

import ProjectDescription

public extension SettingsDictionary {
	static let baseSettings: Self = [
		"OTHER_LDFLAGS" : [
			"$(inherited)",
			"-ObjC"
		]
	]
}
