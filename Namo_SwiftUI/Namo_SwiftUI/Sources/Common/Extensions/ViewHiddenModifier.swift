//
//  ViewHiddenModifier.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/20/24.
//

import Foundation
import SwiftUI

extension View {
    
    func hidden(_ shouldHide: Bool) -> some View {
        modifier(ViewHiddenModifier(isHidden: shouldHide))
    }
}

struct ViewHiddenModifier: ViewModifier {
    
    var isHidden: Bool
    
    func body(content: Content) -> some View {
        
        Group {
            if isHidden {
                content.hidden()
            } else {
                content
            }
        }
    }
}
