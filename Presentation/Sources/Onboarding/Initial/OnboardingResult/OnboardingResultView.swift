//
//  OnboardingResultView.swift
//  Presentation
//
//  Created by 디해 on 7/16/25.
//

import ComposableArchitecture
import SwiftUI

struct OnboardingResultView: View {
    @Bindable var store: StoreOf<OnboardingResultReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 18))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.bottom, 30)
            
            RecipePreviewView(recipePreviewViewData: store.recipePreviewViewData)
                .padding(.bottom, 50)
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
            
            RoundedButton(title: "시작하기") {
                store.send(.didTapStartButton)
            }
        }
        .toolbar(.hidden)
    }
}
