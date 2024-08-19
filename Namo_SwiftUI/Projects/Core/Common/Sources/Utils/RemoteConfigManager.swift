//
//  RemoteConfigManager.swift
//  Namo_SwiftUI
//
//  Created by 정현우 on 6/2/24.
//

import SwiftUI
import FirebaseRemoteConfig

public class RemoteConfigManager {
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
	
	public func getMinimumVersion() async throws -> String? {
		do {
			try await remoteConfig.fetch()
			try await remoteConfig.activate()
			return self.remoteConfig["ios_version"].stringValue
		} catch {
			print("Error: \(error)")
			return nil
		}
	}
	
	public func getBaseUrl() async throws -> String? {
		do {
			try await remoteConfig.fetch()
			try await remoteConfig.activate()
			return self.remoteConfig["ios_baseurl"].stringValue
		} catch {
			print("Error: \(error)")
			return nil
		}
	}
}
