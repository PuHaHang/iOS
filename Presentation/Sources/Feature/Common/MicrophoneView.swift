//
//  MicrophoneView.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import Lottie
import SwiftUI

struct MicrophoneView: View {
    let isActive: Bool
    
    var body: some View {
        Group {
            if isActive {
                LottieView(animation: .named("voice_on"))
                    .looping()
                    .animationSpeed(1.2)
            } else {
                LottieView(animation: .named("voice_on"))
                    .paused()
                    .saturation(0)
                    .opacity(0.3)
            }
        }
        .transition(.scaleAndFade)
        .frame(height: 140)
    }
}

extension AnyTransition {
    static var scaleAndFade: AnyTransition {
        AnyTransition.scale(scale: 0.8)
            .combined(with: .opacity)
    }
}
