//
//  LottieView.swift
//  Namo_SwiftUI
//
//  Created by 고성민 on 1/19/24.
//

import SwiftUI
import Lottie

// Lottie뷰 정의
struct LottieView: UIViewRepresentable {
    
    var fileName: String
    
    func makeUIView(context: Context) -> some UIView {
        
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView(name: fileName)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        NSLayoutConstraint.activate([
            
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
