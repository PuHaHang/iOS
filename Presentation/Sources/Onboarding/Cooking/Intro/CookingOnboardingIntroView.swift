//
//  CookingOnboardingIntroView.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Lottie
import SwiftUI

struct CookingOnboardingIntroView: View {
    @Bindable var store: StoreOf<CookingOnboardingIntroReducer>
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .multilineTextAlignment(.center)
                .padding(.top, 80)
                .padding(.bottom, 50)
            
            Spacer()
            
            LottieView(animation: .named("cooking"))
                .looping()
            
            Spacer()
            
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.bottom, 10)
            
            Text(store.introductionText)
                .font(.system(size: 15))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
                .padding(.bottom, 50)
            
            RoundedButton(title: "시작하기") {
                store.send(.didTapStartButton)
            }
            .padding(.bottom, 50)
        }
        .toolbar(.hidden)
    }
}

