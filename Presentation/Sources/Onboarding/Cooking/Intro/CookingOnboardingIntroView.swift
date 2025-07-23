//
//  CookingOnboardingIntroView.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import SwiftUI

struct CookingOnboardingIntroView: View {
    @Bindable var store: StoreOf<CookingOnboardingIntroReducer>
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .padding(.top, 80)
                .padding(.bottom, 50)
            
            
            Text(store.subTitleText)
                .font(.system(size: 18))
                .fontWeight(.semibold)
                .foregroundStyle(AppColor.Text.subTitle)
                .padding(.bottom, 20)
            
            Text(store.introductionText)
                .font(.system(size: 15))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
            
            Spacer()
            
            RoundedButton(title: "시작하기") {
                store.send(.didTapStartButton)
            }
            .padding(.bottom, 50)
        }
        .toolbar(.hidden)
    }
}

