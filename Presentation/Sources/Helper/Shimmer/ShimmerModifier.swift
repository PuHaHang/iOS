//
//  ShimmerModifier.swift
//  Presentation
//
//  Created by 디해 on 7/27/25.
//

import SwiftUI

import SwiftUI

struct ShimmerModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    let w = geo.size.width
                    let h = geo.size.height

                    TimelineView(.animation) { timeline in
                        let t = timeline.date.timeIntervalSinceReferenceDate
                        let progress = t - floor(t)
                        let x = CGFloat(progress) * (w * 2) - w

                        LinearGradient(
                            colors: [.clear, .white.opacity(0.8), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                        .frame(width: w * 2, height: h)
                        .rotationEffect(.degrees(20))
                        .offset(x: x)
                        .blendMode(.plusLighter)
                    }
                }
                .mask(content)
            }
    }
}
