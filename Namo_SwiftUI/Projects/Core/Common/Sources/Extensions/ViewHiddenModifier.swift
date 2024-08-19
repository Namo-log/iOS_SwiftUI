//
//  ViewHiddenModifier.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/20/24.
//

import Foundation
import SwiftUI

public extension View {
    
    func hidden(_ shouldHide: Bool) -> some View {
        modifier(ViewHiddenModifier(isHidden: shouldHide))
    }
}

public struct ViewHiddenModifier: ViewModifier {
    
    var isHidden: Bool
    
	public func body(content: Content) -> some View {
        
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}
