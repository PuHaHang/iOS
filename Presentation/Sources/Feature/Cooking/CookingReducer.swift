//
//  CookingReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import Entity
import Foundation
import YouTubePlayerKit

@Reducer
struct CookingReducer {
    
    @ObservableState
    struct State {
        @Presents var destination: Destination.State?
        
        let title: String
        let steps: [RecipeStepViewData]
        let reference: ReferenceViewData
        
        var currentStep: Int = 0
        
        var hasSpeechPermission: Bool = false
        var isRecording: Bool = false
        var isRecognizing: Bool = false
        var recognizedText: String = ""
        var isCommand: Bool = false
        
        var startTime: Measurement<UnitDuration> {
            steps[currentStep].timeline.startTime
        }
        
        var endTime: Measurement<UnitDuration> {
            steps[currentStep].timeline.endTime
        }
    }
    
    enum Action {
        case destination(PresentationAction<Destination.Action>)
        
        case didTapPrevButton
        case didTapNextButton
        case didTapSourceButton
        case didTapTimerButton
        case didTapVoiceButton
        
        case requestAuthorization
        case authorizationResult(Bool)
        
        case startListening
        case stopListening
        case receivedCommand(VoiceVO)
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .didTapPrevButton:
                return reduceDidTapPrevButton(&state)
                
            case .didTapNextButton:
                return reduceDidTapNextButton(&state)
                
            case .didTapTimerButton:
                return reduceDidTapTimerButton(&state)
                
            case .didTapVoiceButton:
                return reduceDidTapVoiceButton(&state)
                
            case .didTapSourceButton:
                return reduceDidTapSourceButton(&state)
                
            case .requestAuthorization:
                return reduceRequestAuthorization(state)
                
            case .authorizationResult(let isGranted):
                return reduceAuthorizationResult(&state, isGranted: isGranted)
                
            case .startListening:
                return reduceStartListening(&state)
                
            case .stopListening:
                return reduceStopListening(&state)
                
            case .receivedCommand(let voice):
                return reduceReceivedCommand(&state, voice: voice)
                
            case .destination, .delegate:
                return .none
            }
        }
        .ifLet(\.$destination, action: \.destination) {
            Destination.body
        }
    }
}

private extension CookingReducer {
    func reduceDidTapPrevButton(_ state: inout CookingReducer.State) -> Effect<Action> {
        state.currentStep = max(0, state.currentStep - 1)
        return .none
    }
    
    func reduceDidTapNextButton(_ state: inout CookingReducer.State) -> Effect<Action> {
        if state.currentStep + 1 >= state.steps.count {
            return .send(.delegate(.navigateToResult))
        }  else {
            state.currentStep = state.currentStep + 1
        }
        return .none
    }
    
    func reduceDidTapTimerButton(_ state: inout CookingReducer.State) -> Effect<Action> {
        state.destination = .timer(.init(timerState: .setting))
        return .none
    }
    
    func reduceDidTapVoiceButton(_ state: inout CookingReducer.State) -> Effect<Action> {
        guard state.hasSpeechPermission else { return .none }
        
        state.isRecording.toggle()
        
        if state.isRecording {
            return .send(.startListening)
        } else {
            return .send(.stopListening)
        }
    }
    
    func reduceDidTapSourceButton(_ state: inout CookingReducer.State) -> Effect<Action> {
        state.destination = .player(
            .init(
                reference: state.reference,
                startTime: state.startTime,
                endTime: state.endTime
            )
        )
        return .none
    }
}

private extension CookingReducer {
    func reduceRequestAuthorization(_ state: CookingReducer.State) -> Effect<Action> {
        return .run { send in
            let result = await requestSpeechAuthorizationUseCase.execute()
            await send(.authorizationResult(result))
        }
    }
    
    func reduceAuthorizationResult(_ state: inout CookingReducer.State, isGranted: Bool) -> Effect<Action> {
        if isGranted {
            state.hasSpeechPermission = true
            state.isRecording = true
            state.isRecognizing = true
            return .send(.startListening)
        }
        
        return .none
    }
}

private extension CookingReducer {
    func reduceStartListening(_ state: inout CookingReducer.State) -> Effect<Action> {
        state.isRecording = true
        state.isRecognizing = true
        
        return .run { send in
            let result = await startSpeechRecognitionUseCase.execute()
            switch result {
            case .success(let command):
                await send(.receivedCommand(command))
            case .failure(let error):
                print(">>> error \(error)")
                await send(.startListening)
            }
        }
    }
    
    func reduceStopListening(_ state: inout CookingReducer.State) -> Effect<Action> {
        stopSpeechRecognitionUseCase.execute()
        state.isRecognizing = false
        state.isRecording = false
        return .none
    }
    
    func reduceReceivedCommand(_ state: inout CookingReducer.State, voice: VoiceVO) -> Effect<Action> {
        guard state.isRecording else { return .none }
        state.isRecognizing = false
        state.recognizedText = voice.text
        state.isCommand = (voice.command != .unknown)

        var effects: [Effect<Action>] = []

        let command = voice.command
        switch command {
        case .next:
            effects.append(.send(.didTapNextButton))

        case .previous:
            effects.append(.send(.didTapPrevButton))

        case .playVideo:
            effects.append(.send(.didTapSourceButton))

        case .stopVideo:
            state.destination = nil

        case .timer(let minutes, let seconds):
            state.destination = .timer(
                .init(timerState: .setting, minutes: minutes, seconds: seconds)
            )
            effects.append(.send(.destination(.presented(.timer(.startTimer)))))

        case .stopTimer:
            state.destination = nil

        case .unknown:
            break
        }

        effects.append(
            .run { send in
                try await Task.sleep(nanoseconds: 1_000_000_000)
                await send(.startListening)
            }
        )

        return .merge(effects)
    }
}

extension CookingReducer {
    @Reducer
    enum Destination {
        case player(CookingPlayerReducer)
        case timer(TimerReducer)
    }
}

extension CookingReducer.Action {
    enum Delegate: Equatable {
        case navigateToResult
    }
}
