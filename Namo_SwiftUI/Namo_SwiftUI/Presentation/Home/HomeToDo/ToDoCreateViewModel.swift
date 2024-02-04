//
//  ToDoCreateViewModel.swift
//  Namo_SwiftUI
//
//  Created by 박민서 on 2/1/24.
//

import Foundation


class ToDoCreateViewModel: ObservableObject {
    @Published var test: testDecodeDTO?
    
    /// 테스트
    func fetchTest() async {
        let repo: Example_ScheduleRepository = ScheduleRepositoryTest()
        let result = await repo.test()
        
        test = result
        print(result ?? "결과 불러오기 실패")
    }
    
    /// 실사용
    func fetchData() async {
        let repo: Example_ScheduleRepository = Example_ScheduleRepositoryImpl()
        let result = await repo.test()
        
        test = result
        print(result ?? "결과 불러오기 실패")
    }
}
