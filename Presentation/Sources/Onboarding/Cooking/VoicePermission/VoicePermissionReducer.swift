//
//  VoicePermissionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Foundation
import Shared
import Logger

@Reducer
struct VoicePermissionReducer {
    @Dependency(\.audioService) var audioService
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingVoicePermissionTitle
        let subTitleText: String = LocalizationHelper.onboardingVoicePermissionSubtitle
    }
    
    enum Action {
        case onAppear
        case didTapVoiceButton
        case authorizationResult(Bool)
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.cookingOnboardingVoicePermissionScreen)
                return .none
                
            case .didTapVoiceButton:
                logger.track(.cookingOnboardingVoicePermissionButton)
                return .run { send in
                    let microPhonePermission = await audioService.requestMicrophonePermission()
                    let recognitionPermission = await audioService.requestSpeechRecognitionPermission()
                    let result = microPhonePermission && recognitionPermission
                    
                    await send(.authorizationResult(result))
                }
                
            case .authorizationResult(let result):
                return .send(.delegate(.navigateToCookingIntroduction))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension VoicePermissionReducer {
    enum Delegate: Equatable {
        case navigateToCookingIntroduction
    }
}
