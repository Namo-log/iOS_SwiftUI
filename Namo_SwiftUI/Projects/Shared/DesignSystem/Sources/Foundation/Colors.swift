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
    
    //    static let colorPink = Color(asset: NamoColors.pink)
    //    static let colorPurple = Color(asset: NamoColors.purple)
    //    static let colorYellow = Color(asset: NamoColors.yellow)
    
    static let mainOrange = Color(asset: NamoColors.mainOrange)
    static let mainText = Color(asset: NamoColors.mainText)
    static let mainGray = Color(asset: NamoColors.mainGray)
    
    static let itemBackground = Color(asset: NamoColors.itemBackground)
    static let textDisabled = Color(asset: NamoColors.textDisabled)
    static let textPlaceholder = Color(asset: NamoColors.textPlaceholder)
    static let textUnselected = Color(asset: NamoColors.textUnselected)
    
    // 변경된 컬러들
    static let namoBlue = Color(asset: NamoColors.namoBlue)
    static let namoOrange = Color(asset: NamoColors.namoOrange)
    static let namoPink = Color(asset: NamoColors.namoPink)
    static let namoYellow = Color(asset: NamoColors.namoYellow)
    
    static let colorBlue = Color(asset: NamoColors.blue)
    static let colorCyan = Color(asset: NamoColors.cyan)
    static let colorGray = Color(asset: NamoColors.gray)
    static let colorGreen = Color(asset: NamoColors.green)
    static let colorLavendar = Color(asset: NamoColors.lavendar)
    static let colorLightBlue = Color(asset: NamoColors.lightBlue)
    static let colorLightGray = Color(asset: NamoColors.lightGray)
    static let colorLightGreen = Color(asset: NamoColors.lightGreen)
    static let colorLime = Color(asset: NamoColors.lime)
    static let colorMagenta = Color(asset: NamoColors.magenta)
    static let colorOrange = Color(asset: NamoColors.orange)
    static let colorPink = Color(asset: NamoColors.pink)
    static let colorPurple = Color(asset: NamoColors.purple)
    static let colorRed = Color(asset: NamoColors.red)
    static let colorYellow = Color(asset: NamoColors.yellow)
    static let colorDarkGray = Color(asset: NamoColors.darkGray)
    
    static let NamoColorPalette: [Color] = [
        .namoOrange,
        .namoPink,
        .namoYellow,
        .namoBlue,
        .colorLightGray,
        .colorRed,
        .colorPink,
        .colorOrange,
        .colorYellow,
        .colorLime,
        .colorLightGreen,
        .colorGreen,
        .colorCyan,
        .colorLightBlue,
        .colorBlue,
        .colorLavendar,
        .colorPurple,
        .colorMagenta,
        .colorDarkGray,
        .colorBlack
    ]
}
