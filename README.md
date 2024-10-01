# iOS_SwiftUI
나모의 iOS SwiftUI 레포입니다


# Tuist 모듈 생성 방법
1. 해당하는 모듈 enum에 정의
```
Plugins
├── DependencyPlugin
├──── ProjectDescriptionHelpers
└────── Modules.swift
```
2. 모듈 생성
```
	tuist scaffold domain --name Schedule
	tuist scaffold feature --name Home
```
3. 각 layer의 exported에 정의(Feature, Domain의 Project.swift)
