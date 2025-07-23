//
//  VoicePermissionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct VoicePermissionReducer {
    @Dependency(\.audioService) var audioService
    
    @ObservableState
    struct State {
        let titleText: String = """
            음성 인식을 사용하려면
            권한이 필요해요
            """
        let subTitleText: String = """
            아래 버튼을 눌러
            음성 인식 권한을 켜주세요.
            """
    }
    
    enum Action {
        case didTapVoiceButton
        case authorizationResult(Bool)
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapVoiceButton:
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
