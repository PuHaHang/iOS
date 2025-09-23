//
//  VoicePermissionView.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Lottie
import Shared
import SwiftUI

struct VoicePermissionView: View {
    @Bindable var store: StoreOf<VoicePermissionReducer>
        
    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 20))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.Text.main)
                .padding(.top, 80)
        
            Spacer()
            
            LottieView(animation: .named("speaking_audio"))
                .looping()
                .frame(width: 100, height: 100)
            
            Spacer()
            
            Text(store.subTitleText)
                .font(.system(size: 16))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.main)
                .padding(.bottom, 35)
            
            MiniRoundedButton(title: LocalizationHelper.onboardingCookingVoicePermission) {
                store.send(.didTapVoiceButton)
            }.padding(.bottom, 70)
        }
        .padding(.horizontal, 25)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden)
        .onAppear {
            store.send(.onAppear)
        }
    }
}
