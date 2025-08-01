// CookingIntroductionView.swift

import ComposableArchitecture
import SwiftUI

struct CookingIntroductionView: View {
    @Bindable var store: StoreOf<CookingIntroductionReducer>

    @State var isMicrophoneAnimated = false
    @State var isStepButtonAnimated = false
    @State var isTimerButtonAnimated = false
    @State var isSpeakerButtonAnimated = false

    var body: some View {
        ZStack {
            Color.clear

            VStack(spacing: 0) {
                TitleSection(store: store)
                Spacer()
                IntroductionSection(store: store)
                if store.isMicrophoneButtonVisible {
                    MicrophoneButtonView(
                        isAnimated: isMicrophoneAnimated,
                        isVisible: store.introductionState == .microphone
                    )
                }
                StepControlSection(
                    store: store,
                    isAnimated: isStepButtonAnimated
                )
                SkipText(text: store.skipIntroductionText)
            }
        }
        .contentShape(Rectangle())
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                TimerToolbarButtonView(
                    isVisible: store.isTimerButtonVisible,
                    isAnimated: isTimerButtonAnimated,
                    shouldAnimate: store.introductionState == .timer
                )
            }

            ToolbarItem(placement: .topBarTrailing) {
                SpeakerToolbarButtonView(
                    isVisible: store.isSpeakerButtonVisible,
                    isAnimated: isSpeakerButtonAnimated,
                    shouldAnimate: store.introductionState == .speaker
                )
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
            case .idle: break
            case .microphone: isMicrophoneAnimated = true
            case .step, .play: isStepButtonAnimated = true
            case .timer: isTimerButtonAnimated = true
            case .speaker: isSpeakerButtonAnimated = true
            }
        }
    }
}

// MARK: - Subviews

private struct TitleSection: View {
    let store: StoreOf<CookingIntroductionReducer>

    var body: some View {
        VStack(spacing: 0) {
            Text(store.titleText)
                .font(.system(size: 18, weight: .semibold))
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.Text.main)
                .padding(.top, 80)
                .padding(.bottom, 30)

            if let subTitle = store.subTitleText {
                Text(subTitle)
                    .font(.system(size: 15, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(AppColor.main)
            }
        }
    }
}

private struct IntroductionSection: View {
    let store: StoreOf<CookingIntroductionReducer>

    var body: some View {
        if let intro = store.introductionText {
            Text(intro)
                .font(.system(size: 14, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundStyle(AppColor.main)
        }
    }
}

private struct MicrophoneButtonView: View {
    let isAnimated: Bool
    let isVisible: Bool

    var body: some View {
        MicrophoneView(isActive: false)
            .background(
                Circle()
                    .fill(Color.blue.opacity(0.3))
                    .scaleEffect(isAnimated ? 1.2 : 1.0)
                    .opacity(isAnimated ? 0.0 : 0.6)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isAnimated)
                    .opacity(isVisible ? 1.0 : 0.0)
            )
    }
}

private struct StepControlSection: View {
    let store: StoreOf<CookingIntroductionReducer>
    let isAnimated: Bool

    var body: some View {
        StepControlBar(isPlayEnabled: store.isPlayButtonVisible)
            .opacity((store.isStepButtonVisible || store.isPlayButtonVisible) ? 1.0 : 0.0)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.3))
                    .scaleEffect(isAnimated ? 1.7 : 1.5)
                    .opacity(isAnimated ? 0.0 : 0.6)
                    .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isAnimated)
                    .opacity((store.introductionState == .step || store.introductionState == .play) ? 1.0 : 0.0)
            )
            .allowsHitTesting(false)
            .padding(.bottom, 20)
            .padding(.horizontal, 30)
    }
}

private struct SkipText: View {
    let text: String

    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .medium))
            .foregroundStyle(AppColor.Text.information)
            .padding(.bottom, 30)
    }
}

private struct TimerToolbarButtonView: View {
    let isVisible: Bool
    let isAnimated: Bool
    let shouldAnimate: Bool

    var body: some View {
        Button(action: {}) {
            Image(systemName: "timer")
                .foregroundStyle(.black)
                .opacity(isVisible ? 1.0 : 0.0)
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .scaleEffect(isAnimated ? 1.7 : 1.5)
                        .opacity(isAnimated ? 0.0 : 0.6)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isAnimated)
                        .opacity(shouldAnimate ? 1.0 : 0.0)
                )
        }
        .allowsHitTesting(false)
    }
}

private struct SpeakerToolbarButtonView: View {
    let isVisible: Bool
    let isAnimated: Bool
    let shouldAnimate: Bool

    var body: some View {
        Button(action: {}) {
            Image(systemName: "ear")
                .foregroundStyle(.black)
                .opacity(isVisible ? 1.0 : 0.0)
                .background(
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .scaleEffect(isAnimated ? 1.7 : 1.5)
                        .opacity(isAnimated ? 0.0 : 0.6)
                        .animation(.easeInOut(duration: 1.5).repeatForever(autoreverses: false), value: isAnimated)
                        .opacity(shouldAnimate ? 1.0 : 0.0)
                )
        }
        .allowsHitTesting(false)
    }
}
