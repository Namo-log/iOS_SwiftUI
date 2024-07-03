//
//  FactoryDI.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/18/24.
//

import Foundation
import Factory

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
    
    // 프로토콜 타입 지정 후 실제 구현체를 넣어준다는 의미입니다.
    var authInteractor: Factory<AuthInteractor> {
        self { APIAuthInteractorImpl() }
            .singleton
    }
    
    var authRepository: Factory<AuthRepository> {
        self { APIAuthRepositoryImpl() }
            .singleton
    }
    
    var scheduleInteractor: Factory<ScheduleInteractor> {
        self { ScheduleInteractorImpl() }
            .singleton
    }
    
    var scheduleRepository: Factory<ScheduleRepository> {
        self { ScheduleRepositoryImpl() }
            .singleton
    }
    
    var categoryInteractor: Factory<CategoryInteractor> {
        self { CategoryInteractorImpl() }
            .singleton
    }
    
    var categoryRepository: Factory<CategoryRepository> {
        self { CategoryRepositoryImpl() }
            .singleton
    }
    
    var moimInteractor: Factory<MoimInteractor> {
        self { MoimInteractorImpl() }
            .singleton
    }
    
    var moimRepository: Factory<MoimRepository> {
        self { MoimRepositoryImpl() }
            .singleton
    }
    
    var placeInteractor: Factory<PlaceInteractor> {
        self { PlaceInteractorImpl() }
            .singleton
    }
    
    var placeRepository: Factory<PlaceRepository> {
        self { PlaceRepositoryImpl() }
            .singleton
    }
    
    var diaryInteractor: Factory<DiaryInteractor> {
        self { DiaryInteractorImpl() }
            .singleton
    }
    
    var diaryRepository: Factory<DiaryRepository> {
        self { DiaryRepositoryImpl() }
            .singleton
    }
    
    var moimDiaryInteractor: Factory<MoimDiaryInteractor> {
        self { MoimDiaryInteractorImpl() }
            .singleton
    }
    
    var moimDiaryRepository: Factory<MoimDiaryRepository> {
        self { MoimDiaryRepositoryImpl() }
            .singleton
    }
  
    var userRepository: Factory<UserRepository> {
        self { UserRepositoryImpl() }
            .singleton
    }    
}
