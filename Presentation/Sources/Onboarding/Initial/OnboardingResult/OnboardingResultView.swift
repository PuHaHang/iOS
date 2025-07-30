//
//  OnboardingResultView.swift
//  Presentation
//
//  Created by 디해 on 7/16/25.
//

import ComposableArchitecture
import Kingfisher
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
            
            KFImage.url(store.imageURL)
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 480)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
                )
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
