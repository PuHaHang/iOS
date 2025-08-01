//
//  CookingCompletionView.swift
//  Presentation
//
//  Created by 디해 on 7/23/25.
//

import ComposableArchitecture
import Lottie
import Shared
import SwiftUI

struct CookingCompletionView: View {
    @Bindable var store: StoreOf<CookingCompletionReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.Text.main)
                .padding(.top, 80)
            
            Spacer()
            
            LottieView(animation: .named("ingredients"))
                .looping()
            
            Spacer()
            
            RoundedButton(title: LocalizationHelper.onboardingCookingCompletionOk) {
                store.send(.didTapComfirmButton)
            }
            .padding(.bottom, 50)
        }
        .toolbar(.hidden)
        .onAppear {
            store.send(.onAppear)
        }
    }
}
