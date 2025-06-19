//
//  CookingView.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import SwiftUI

struct CookingView: View {
    @Bindable var store: StoreOf<CookingReducer>
    
    var body: some View {
        VStack {
            Spacer()
            
            CookingStepView(
                title: store.steps[store.currentStep].stepTitle,
                content: store.steps[store.currentStep].stepContent
            )
            .padding(.horizontal, 30)
            
            Spacer()
            
            StepControlBar(
                onPrevious: {
                    store.send(.didTapPrevButton)
                },
                onPlay: {
                    store.send(.didTapSourceButton)
                },
                onNext: {
                    store.send(.didTapNextButton)
                }
            )
            .padding(.horizontal, 30)
            .padding(.bottom, 30)
        }
        .navigationTitle(store.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

extension CookingView {
    private struct CookingStepView: View {
        let title: String
        let content: String
        
        var body: some View {
            VStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 22))
                    .fontWeight(.bold)
                    .foregroundStyle(AppColor.Text.step)
                
                Text(content)
                    .font(.system(size: 35))
                    .fontWeight(.heavy)
                    .foregroundStyle(AppColor.Text.normalInstruction)
            }
        }
    }
    
    private struct StepControlBar: View {
        let onPrevious: () -> Void
        let onPlay: () -> Void
        let onNext: () -> Void

        var body: some View {
            HStack(spacing: 10) {
                RoundedButton(
                    title: "이전",
                    isEnabled: true,
                    action: onPrevious
                )
                RoundedButton(
                    systemImageName: "play.fill",
                    isEnabled: true,
                    action: onPlay
                )
                RoundedButton(
                    title: "다음",
                    isEnabled: true,
                    action: onNext
                )
            }
        }
    }
}
