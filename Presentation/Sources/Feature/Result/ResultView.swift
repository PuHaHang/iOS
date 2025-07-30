//
//  ResultView.swift
//  PuHaHang
//
//  Created by 디해 on 6/17/25.
//

import ComposableArchitecture
import Lottie
import Shared
import SwiftUI

struct ResultView: View {
    @Bindable var store: StoreOf<ResultReducer>
    
    var body: some View {
        VStack {
            Spacer()
            
            RecipeCompletionView(title: store.title)
            
            Spacer()
            
            RoundedButton(title: LocalizationHelper.cookingCompletionHome) {
                store.send(.didTapHomeButton)
            }
            .padding(.bottom, 20)
        }
        .navigationBarBackButtonHidden()
    }
}

extension ResultView {
    private struct RecipeCompletionView: View {
        let title: String

        var body: some View {
            VStack(spacing: 0) {
                Text(title)
                    .font(.system(size: 28))
                    .foregroundStyle(AppColor.Text.highlight)
                    .fontWeight(.bold)
                    .padding(.bottom, 5)
                
                Text(LocalizationHelper.cookingCompletionTitle)
                    .font(.system(size: 22))
                    .foregroundStyle(AppColor.Text.main)
                    .fontWeight(.semibold)
                    .padding(.bottom, 20)
                
                LottieView(animation: .named("celebration"))
                    .looping()
                    .animationSpeed(0.4)
                    .frame(maxHeight: 200)
            }
        }
    }
}
