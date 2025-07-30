//
//  ShimmerModifier.swift
//  Presentation
//
//  Created by 디해 on 7/27/25.
//

import SwiftUI

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = -200

    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader { geometry in
                    let width = geometry.size.width
                    let height = geometry.size.height

                    LinearGradient(
                        gradient: Gradient(colors: [
                            .clear,
                            Color.white.opacity(0.8),
                            .clear
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .frame(width: width * 2, height: height)
                    .rotationEffect(.degrees(20))
                    .offset(x: phase)
                    .blendMode(.plusLighter)
                }
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.0)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 400
                }
            }
    }
}
