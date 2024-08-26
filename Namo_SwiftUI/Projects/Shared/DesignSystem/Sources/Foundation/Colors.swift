//
//  Colors.swift
//  SharedDesignSystem
//
//  Created by 권석기 on 8/26/24.
//

import Foundation
import SwiftUI

public typealias NamoColors = SharedDesignSystemAsset.Assets

public extension Color {
    static let colorBlack = Color(asset: NamoColors.black)
    static let colorBlue = Color(asset: NamoColors.blue)
    static let colorPink = Color(asset: NamoColors.pink)
    static let colorPurple = Color(asset: NamoColors.purple)
    static let colorYellow = Color(asset: NamoColors.yellow)
    
    static let mainOrange = Color(asset: NamoColors.mainOrange)
    static let mainText = Color(asset: NamoColors.mainText)
    
    static let itemBackground = Color(asset: NamoColors.itemBackground)
    
    static let textDisabled = Color(asset: NamoColors.textDisabled)
    static let textPlaceholder = Color(asset: NamoColors.textPlaceholder)
    static let textUnselected = Color(asset: NamoColors.textUnselected)
    
}
