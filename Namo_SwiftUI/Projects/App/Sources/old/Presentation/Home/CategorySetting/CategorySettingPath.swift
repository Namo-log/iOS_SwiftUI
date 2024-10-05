////
////  CategorySettingPath.swift
////  Namo_SwiftUI
////
////  Created by 고성민 on 3/13/24.
////
//
//import Foundation
//import SwiftUI
//
///// 카테고리 설정 부분 NavigationPath 화면 경로 
//enum CategoryViews {
//    
//    case TodoSelectCategoryView
//    case CategorySettingView
//    case CategoryAddView
//    case CategoryEditView
//}
//
//struct CategoryPath {
//    
//    var id: CategoryViews
//    var path: NavigationPath
//    
//    static func setCategoryPath(id: CategoryViews, path: Binding<NavigationPath>) -> AnyView {
//        
//        switch id {
//            
//        case .TodoSelectCategoryView:
//            return AnyView(ToDoSelectCategoryView(path: path))
//        case .CategorySettingView:
//            return AnyView(CategorySettingView(path: path))
//        case .CategoryAddView:
//            return AnyView(CategoryAddView(path: path))
//        case .CategoryEditView:
//            return AnyView(CategoryEditView(path: path))
//        }
//    }
//}
