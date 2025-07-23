//
//  CookingIntroductionView.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import SwiftUI

struct CookingIntroductionView: View {
    @Bindable var store: StoreOf<CookingIntroductionReducer>
    
    @State var isMicrophoneAnimated: Bool = false
    @State var isStepButtonAnimated: Bool = false
    @State var isTimerButtonAnimated: Bool = false
    @State var isSpeakerButtonAnimated: Bool = false
    
    var body: some View {
        ZStack {
            Color.clear

            VStack(spacing: 0) {
                Text(store.titleText)
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppColor.Text.main)
                    .padding(.top, 80)
                    .padding(.bottom, 30)
                
                if let subTitleText = store.subTitleText {
                    Text(subTitleText)
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .fontWeight(.semibold)
                        .foregroundStyle(AppColor.main)
                }
                
                Spacer()
                
                if let introductionText = store.introductionText {
                    Text(introductionText)
                        .font(.system(size: 14))
                        .fontWeight(.medium)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(AppColor.main)
                }
                
                if store.isMicrophoneButtonVisible {
                    MicrophoneView(isActive: false)
                        .background(
                            Circle()
                                .fill(Color.blue.opacity(0.3))
                                .scaleEffect(isMicrophoneAnimated ? 1.2 : 1.0)
                                .opacity(isMicrophoneAnimated ? 0.0 : 0.6)
                                .animation(
                                    .easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: false),
                                    value: isMicrophoneAnimated
                                )
                                .opacity(store.introductionState == .microphone ? 1.0 : 0.0)
                        )
                }
                
                StepControlBar(isPlayEnabled: store.isPlayableButtonVisible)
                    .opacity((store.isStepButtonVisible || store.isPlayableButtonVisible) ? 1.0 : 0.0)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.blue.opacity(0.3))
                            .scaleEffect(isStepButtonAnimated ? 1.7 : 1.5)
                            .opacity(isStepButtonAnimated ? 0.0 : 0.6)
                            .animation(
                                .easeInOut(duration: 1.5)
                                .repeatForever(autoreverses: false),
                                value: isStepButtonAnimated
                            )
                            .opacity((store.introductionState == .step || store.introductionState == .play) ? 1.0 : 0.0)
                    )
                    .allowsHitTesting(false)
                    .padding(.bottom, 20)
                    .padding(.horizontal, 30)
                
                Text(store.skipIntroductionText)
                    .font(.system(size: 14))
                    .fontWeight(.medium)
                    .foregroundStyle(AppColor.Text.information)
                    .padding(.bottom, 30)
            }
        }
        .contentShape(Rectangle())
        .navigationBarBackButtonHidden()
        .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {}) {
                        Image(systemName: "timer")
                            .foregroundStyle(.black)
                            .opacity(store.isTimerButtonVisible ? 1.0 : 0.0)
                            .background(
                                Circle()
                                    .fill(Color.blue.opacity(0.3))
                                    .scaleEffect(isTimerButtonAnimated ? 1.7 : 1.5)
                                    .opacity(isTimerButtonAnimated ? 0.0 : 0.6)
                                    .animation(
                                        .easeInOut(duration: 1.5)
                                        .repeatForever(autoreverses: false),
                                        value: isTimerButtonAnimated
                                    )
                                    .opacity(store.introductionState == .timer ? 1.0 : 0.0)
                            )
                    }
                    .allowsHitTesting(false)
                }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {}) {
                    Image(systemName: "ear")
                        .foregroundStyle(.black)
                        .opacity(store.isSpeakerButtonVisible ? 1.0 : 0.0)
                        .background(
                            Circle()
                                .fill(Color.blue.opacity(0.3))
                                .scaleEffect(isSpeakerButtonAnimated ? 1.7 : 1.5)
                                .opacity(isSpeakerButtonAnimated ? 0.0 : 0.6)
                                .animation(
                                    .easeInOut(duration: 1.5)
                                    .repeatForever(autoreverses: false),
                                    value: isSpeakerButtonAnimated
                                )
                                .opacity(store.introductionState == .speaker ? 1.0 : 0.0)
                        )
                }
                .allowsHitTesting(false)
            }
        }
        .onAppear {
            store.send(.onAppear)
        }
        .onTapGesture {
            store.send(.didTapBackground)
        }
        .onChange(of: store.introductionState) { _, newValue in
            guard newValue != .play else { return }
            
            isMicrophoneAnimated = false
            isStepButtonAnimated = false
            isTimerButtonAnimated = false
            isSpeakerButtonAnimated = false
            
            switch newValue {
            case .idle:
                return
            case .microphone:
                isMicrophoneAnimated = true
            case .step:
                isStepButtonAnimated = true
            case .play:
                isStepButtonAnimated = true
            case .timer:
                isTimerButtonAnimated = true
            case .speaker:
                isSpeakerButtonAnimated = true
            }
        }
    }
}
