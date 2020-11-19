//
//  LottieAnimationView.swift
//  FirstDemo
//
//  Created by 张庆德 on 2020/10/9.
//  Copyright © 2020 张庆德. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieAnimationView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var name: String!
    @Binding var play:Bool
    
    var animationView = AnimationView()

    class Coordinator: NSObject {
        var parent: LottieAnimationView
    
        init(_ animationView: LottieAnimationView) {
            self.parent = animationView
            super.init()
        }
    }

    func makeUIView(context: UIViewRepresentableContext<LottieAnimationView>) -> UIView {
        let view = UIView()

        animationView.animation = Animation.named(name)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieAnimationView>) {
        animationView.play()
    }
}
