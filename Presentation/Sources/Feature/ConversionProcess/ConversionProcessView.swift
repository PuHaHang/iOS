//
//  ConversionProcessView.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Lottie
import Shared
import SwiftUI

struct ConversionProcessView: View {
    @Bindable var store: StoreOf<ConversionProcessReducer>
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            RecipeConvertingView()
            .offset(y: -45)
            
            Spacer()
        }
        .toolbar(.hidden)
        .onAppear {
            store.send(.onAppear)
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .background:
                print(">>> background")
                store.send(.appDidEnterBackground)
            case .active:
                print(">>> foreground")
                store.send(.appWillEnterForeground)
            case .inactive:
                break
            @unknown default:
                break
            }
        }
        .errorDialog(
            title: store.errorState.dialogTitle,
            message: store.errorState.dialogMessage,
            isPresented: .init(
                get: { store.errorState.showDialog },
                set: { _ in store.send(.clearError) }
            ),
            onBackAction: store.errorState.showBackButton ? {
                store.send(.clearError)
            } : nil,
            showBackButton: store.errorState.showBackButton
        )
    }
}

struct RecipeConvertingView: View {
    var body: some View {
        VStack(spacing: 0) {
            LottieView(animation: .named("recipe_conversion_process"))
                .looping()
                .aspectRatio(contentMode: .fit)
                .frame(width: 140)
                .padding(.bottom, 33)
            
            Text(LocalizationHelper.conversionProcessTitle)
                .fontWeight(.bold)
                .font(.system(size: 23))
                .padding(.bottom, 25)
                .foregroundStyle(AppColor.Text.main)
            
            Text(LocalizationHelper.conversionProcessSubtitle)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .foregroundStyle(AppColor.Text.information)
                .multilineTextAlignment(.center)
        }
    }
}
