//
//  CookingView.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import Lottie
import Shared
import SwiftUI

struct CookingView: View {
    @Bindable var store: StoreOf<CookingReducer>
    
    var body: some View {
        ZStack {
            CookingMainView(store: store)
            
            if let store = store.scope(state: \.destination?.player, action: \.destination.player) {
                CookingPlayerView(store: store)
                    .zIndex(1)
            }
            
            if let store = store.scope(state: \.destination?.timer, action: \.destination.timer) {
                TimerView(store: store)
                    .zIndex(1)
            }
        }
        .animation(.easeInOut, value: store.destination != nil)
        .navigationTitle(store.title)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    store.send(.didTapTimerButton)
                }) {
                    Image(systemName: "timer")
                        .foregroundStyle(.black)
                }
                .disabled(store.isPresentingModal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    store.send(.didTapSpeakingButton)
                }) {
                    Image(systemName: "ear")
                        .foregroundStyle(.black)
                }
                .disabled(store.isPresentingModal)
            }
        }
        .onAppear {
            store.send(.requestAuthorization)
        }
    }
}

extension CookingView {
    private struct CookingMainView: View {
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
                
                MicrophoneControlBar(store: store)
                
                StepControlBar(
                    isPlayEnabled: store.reference.hasExternalLink,
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
        }
    }
    
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
    
    private struct MicrophoneControlBar: View {
        @Bindable var store: StoreOf<CookingReducer>
        
        var body: some View {
            ZStack {
                if store.isRecording {
                    if store.isRecognizing {
                        MicrophoneView(isActive: true)
                            .onTapGesture {
                                store.send(.didTapVoiceButton)
                            }
                    } else {
                        VoiceBalloonView(
                            text: store.recognizedText,
                            isValid: store.isCommand
                        )
                        .transition(.scaleAndFade)
                    }
                } else {
                    MicrophoneView(isActive: false)
                        .onTapGesture {
                            store.send(.didTapVoiceButton)
                        }
                }
            }
            .animation(.easeInOut(duration: 0.2), value: store.isRecognizing)
        }
    }

    private struct VoiceBalloonView: View {
        let text: String
        let isValid: Bool

        var body: some View {
            ZStack {
                Rectangle()
                    .fill(isValid ? AppColor.Voice.validBackground : AppColor.Voice.invalidBackground)
                    .cornerRadius(30)
                    .padding(.horizontal, 32)
                    .frame(height: 60)
                    .padding(.vertical, 40)

                Text("\"\(text)\"")
                    .foregroundStyle(isValid ? AppColor.Text.validVoice : AppColor.Text.invalidVoice)
                    .font(.system(size: 16))
                    .fontWeight(.regular)
            }
        }
    }
}

struct StepControlBar: View {
    let isPlayEnabled: Bool
    
    let onPrevious: () -> Void
    let onPlay: () -> Void
    let onNext: () -> Void

    init(
        isPlayEnabled: Bool,
        onPrevious: (() -> Void)? = nil,
        onPlay: (() -> Void)? = nil,
        onNext: (() -> Void)? = nil
    ) {
        self.isPlayEnabled = isPlayEnabled
        self.onPrevious = onPrevious ?? {}
        self.onPlay = onPlay ?? {}
        self.onNext = onNext ?? {}
    }

    var body: some View {
        HStack(spacing: 10) {
            RoundedButton(
                title: LocalizationHelper.cookingPrevious,
                isEnabled: true,
                action: onPrevious
            )
            RoundedButton(
                systemImageName: "play.fill",
                isEnabled: isPlayEnabled,
                action: onPlay
            )
            RoundedButton(
                title: LocalizationHelper.cookingNext,
                isEnabled: true,
                action: onNext
            )
        }
    }
}
