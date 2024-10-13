//
//  RemoteConfigManager.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 6/2/24.
//

import SwiftUI
import FirebaseRemoteConfig

public final class RemoteConfigManager {
	var remoteConfig = RemoteConfig.remoteConfig()
	var settings = RemoteConfigSettings()
	
	public init() {
		setupRemoteConfigListener()
	}
	
	// MARK: - RemoteConfig 리스너 설정
	public func setupRemoteConfigListener() {
		self.settings.minimumFetchInterval = 0
		self.remoteConfig.configSettings = settings
		remoteConfig.addOnConfigUpdateListener { configUpdate, error in
			if let error {
				print("Error: \(error)")
				return
			}
		}
	}
	
	public func getMinimumVersion() async throws -> String {
        try await remoteConfig.fetch()
        try await remoteConfig.activate()
        return self.remoteConfig["ios_version"].stringValue
	}
	
    // 업데이트가 필요하면 true를, 필요없다면 false를
    public func checkUpdateRequired() async throws -> Bool {
        let minimumVersion = try await self.getMinimumVersion()
        let currentVersion = version
        
        // 버전 문자열을 '.'을 기준으로 나누어 배열로 변환
        let minimumVersionComponents = minimumVersion.split(separator: ".").map { Int($0) ?? 0 }
        let currentVersionComponents = currentVersion.split(separator: ".").map { Int($0) ?? 0 }
        
        // 두 배열의 길이를 맞추기 위해 짧은 배열에 0 추가
        let maxLength = max(minimumVersionComponents.count, currentVersionComponents.count)
        let paddedMinimumVersion = minimumVersionComponents + Array(repeating: 0, count: maxLength - minimumVersionComponents.count)
        let paddedCurrentVersion = currentVersionComponents + Array(repeating: 0, count: maxLength - currentVersionComponents.count)
        
        // 각 버전 숫자를 비교
        for (min, cur) in zip(paddedMinimumVersion, paddedCurrentVersion) {
            if cur < min {
                return true // 업데이트가 필요함
            } else if cur > min {
                return false // 업데이트가 필요하지 않음
            }
        }
        
        return false // 두 버전이 같음
    }
    
	public func getBaseUrl() async throws -> String? {
        try await remoteConfig.fetch()
        try await remoteConfig.activate()
        return self.remoteConfig["ios_baseurl"].stringValue
	}
}
