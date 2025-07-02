//
//  RecipeStepView.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import ComposableArchitecture
import SwiftUI

struct RecipeStepView: View {
    @Bindable var store: StoreOf<RecipeStepReducer>
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(store.steps) { step in
                RecipeStepItemView(
                    step: step.stepTitle,
                    content: step.stepContent
                )
            }
            
            Color.clear
                .frame(height: 90)
        }
        .padding(.horizontal, 10)
    }
}
