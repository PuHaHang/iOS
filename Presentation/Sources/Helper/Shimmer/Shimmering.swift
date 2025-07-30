//
//  Shimmering.swift
//  Presentation
//
//  Created by 디해 on 7/27/25.
//

import SwiftUI

extension View {
    func shimmering() -> some View {
        self.modifier(ShimmerModifier())
    }
}
