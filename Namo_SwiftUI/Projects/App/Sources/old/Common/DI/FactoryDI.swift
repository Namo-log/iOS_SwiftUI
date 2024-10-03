//
//  FactoryDI.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import Foundation
import Factory
import FeatureMoimInterface
import FeatureMoim
import SwiftUI

extension Container {
    
    // 예시로 넣어둔 Factory 컨테이너 요소들이며 실제 구현에 쓰일 예정입니다.
    // 구현체들에 주입될 요소들입니다.
    
//    var appState: Factory<AppState> {
//        self { AppState() }
//            .singleton
//    }
	
	var scheduleState: Factory<ScheduleState> {
		self { ScheduleState() }
			.singleton
	}
	
	var moimState: Factory<MoimState> {
		self { MoimState() }
			.singleton
	}
    
    var diaryState: Factory<DiaryState> {
        self { DiaryState() }
            .singleton
    }
    
//    var scheduleRepository: Factory<ScheduleRepository> {
//        self { ScheduleRepositoryImpl() }
//            .singleton
//    }
    
//    var categoryRepository: Factory<CategoryRepository> {
//        self { CategoryRepositoryImpl() }
//            .singleton
//    }
    
    var moimRepository: Factory<MoimRepository> {
        self { MoimRepositoryImpl() }
            .singleton
    }
    
    var placeRepository: Factory<PlaceRepository> {
        self { PlaceRepositoryImpl() }
            .singleton
    }
    
//    var diaryRepository: Factory<DiaryRepository> {
//        self { DiaryRepositoryImpl() }
//            .singleton
//    }
//    
//    var moimDiaryRepository: Factory<MoimDiaryRepository> {
//        self { MoimDiaryRepositoryImpl() }
//            .singleton
//    }
    
    var termRepository: Factory<TermRepository> {
        self { TermRepositoryImpl() }
            .singleton
    }
    
    var authRepository: Factory<AuthRepository> {
        self { AuthRepositoryImpl() }
            .singleton
    }
}
