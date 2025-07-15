//
//  IntroductionView.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import SwiftUI

struct IntroductionView: View {
    @Bindable var store: StoreOf<IntroductionReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.bold)
                .foregroundStyle(AppColor.Text.main)
                .multilineTextAlignment(.center)
                .padding(.top, 80)
                .padding(.bottom, 15)
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
            
            Spacer()
            
            RoundedButton(title: "다음") {
                store.send(.didTapNextButton)
            }
            .padding(.bottom, 50)
        }
        .toolbar(.hidden)
    }
}
