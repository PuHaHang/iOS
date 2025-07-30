//
//  LoginView.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Lottie
import SwiftUI

struct LoginView: View {
    @Bindable var store: StoreOf<LoginReducer>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ContentView(store: store)
        } destination: { store in
            switch store.case {
            case .introduction(let store):
                IntroductionView(store: store)
            case .example(let store):
                ConversionExampleView(store: store)
            case .process(let store):
                OnboardingConversionView(store: store)
            case .result(let store):
                OnboardingResultView(store: store)
            }
        }
    }
    
    private struct ContentView: View {
        @Bindable var store: StoreOf<LoginReducer>

        var body: some View {
            VStack {
                Text(store.titleText)
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .foregroundStyle(AppColor.Text.main)
                    .padding(.top, 80)
                    .padding(.bottom, 20)
                
                Text(store.subTitleText)
                    .font(.system(size: 16))
                    .fontWeight(.medium)
                    .foregroundStyle(AppColor.Text.information)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                
                LottieView(animation: .named("kitchen"))
                    .looping()
                
                Spacer()
                
                RoundedButton(title: "시작하기") {
                    store.send(.didTapStartButton)
                }
                .padding(.bottom, 50)
            }
        }
    }
}
