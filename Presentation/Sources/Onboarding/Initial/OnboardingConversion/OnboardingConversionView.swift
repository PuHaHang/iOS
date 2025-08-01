//
//  OnboardingConversionView.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Shared
import SwiftUI

struct OnboardingConversionView: View {
    @Bindable var store: StoreOf<OnboardingConversionReducer>
    
    var body: some View {
        VStack(spacing: 0) {
            RecipeConvertingView()
                .padding(.bottom, 25)
            
            Text(store.permissionGuideText)
                .font(.system(size: 14))
                .fontWeight(.semibold)
                .foregroundStyle(AppColor.main)
                .multilineTextAlignment(.center)
                .padding(.bottom, 43)
            
            MiniRoundedButton(title: LocalizationHelper.onboardingConversionNotification) {
                store.send(.didTapNotiPermissionButton)
            }
        }
        .toolbar(.hidden)
        .offset(y: -45)
        .onAppear {
            store.send(.onAppear)
        }
    }
}

struct MiniRoundedButton: View {
    private let title: String
    private let action: () -> Void
    
    init(title: String, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.semibold)
        }
        .foregroundStyle(.white)
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
        .background(AppColor.main)
        .cornerRadius(30)
    }
}
