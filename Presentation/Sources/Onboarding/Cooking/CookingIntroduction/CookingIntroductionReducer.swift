//
//  VoiceIntroductionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Foundation
import Shared

@Reducer
struct CookingIntroductionReducer {
    @ObservableState
    struct State {
        var introductionState: IntroductionState = .idle
        
        let skipIntroductionText: String = LocalizationHelper.cookingIntroductionSkip
        
        var titleText: String {
            introductionState.titleText
        }
        
        var subTitleText: String? {
            introductionState.subTitleText
        }
        
        var introductionText: String? {
            return introductionState == .microphone ? LocalizationHelper.cookingIntroductionMicrophoneIntroduction : nil
        }
        
        var isMicrophoneButtonVisible: Bool {
            introductionState >= .microphone
        }
        
        var isStepButtonVisible: Bool {
            introductionState >= .step
        }
        
        var isPlayableButtonVisible: Bool {
            introductionState >= .play
        }
        
        var isTimerButtonVisible: Bool {
            introductionState >= .timer
        }
        
        var isSpeakerButtonVisible: Bool {
            introductionState >= .speaker
        }
    }
    
    enum Action {
        case onAppear
        case didTapBackground
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                guard state.introductionState == .idle else { return .none }
                state.introductionState = .microphone
                return .none
                
            case .didTapBackground:
                guard let nextState = state.introductionState.next() else {
                    return .send(.delegate(.navigateToCompletion))
                }
                state.introductionState = nextState
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}

extension CookingIntroductionReducer {
    enum Delegate {
        case navigateToCompletion
    }
}

extension CookingIntroductionReducer {
    enum IntroductionState: Int, Comparable {
        case idle
        case microphone
        case step
        case play
        case timer
        case speaker
        
        var titleText: String {
            switch self {
            case .idle: ""
            case .microphone: LocalizationHelper.cookingIntroductionMicrophoneTitle
            case .step: LocalizationHelper.cookingIntroductionStepTitle
            case .play: LocalizationHelper.cookingIntroductionPlayTitle
            case .timer: LocalizationHelper.cookingIntroductionTimerTitle
            case .speaker: LocalizationHelper.cookingIntroductionSpeakerTitle
            }
        }
        
        var subTitleText: String? {
            switch self {
            case .idle: nil
            case .microphone: nil
            case .step: LocalizationHelper.cookingIntroductionStepSubtitle
            case .play: LocalizationHelper.cookingIntroductionPlaySubtitle
            case .timer: LocalizationHelper.cookingIntroductionTimerSubtitle
            case .speaker: LocalizationHelper.cookingIntroductionSpeakerSubtitle
            }
        }
        
        func next() -> IntroductionState? {
            IntroductionState(rawValue: self.rawValue + 1)
        }
        
        static func < (lhs: IntroductionState, rhs: IntroductionState) -> Bool {
            lhs.rawValue < rhs.rawValue
        }
    }
}
