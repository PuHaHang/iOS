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
import Logger

@Reducer
struct CookingReducer {
    @Dependency(\.audioService) var audioService
    @Dependency(\.logger) var logger
    
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
        var isSpeaking: Bool = false
        var isPlaying: Bool = false
        var recognizedText: String = ""
        var isCommand: Bool = false
        
        var startTime: Measurement<UnitDuration>? {
            steps[currentStep].timeline?.startTime
        }
        
        var endTime: Measurement<UnitDuration>? {
            steps[currentStep].timeline?.endTime
        }
        
        var isPresentingModal: Bool {
            destination != nil
        }
    }
    
    enum Action {
        case onAppear
        case destination(PresentationAction<Destination.Action>)
        
        case didTapPrevButton
        case didTapNextButton
        case didTapSourceButton
        case didTapTimerButton
        case didTapVoiceButton
        case didTapSpeakingButton
        case didFinishReading
        
        case requestAuthorization
        case authorizationResult(Bool)
        
        case startListening
        case stopListening
        case startRecognizing
        case stopRecognizing
        case receivedCommand(VoiceVO)
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .onAppear:
                logger.track(.cookingScreen)
                return .none
                
            case .didTapPrevButton:
                logger.track(.cookingPrevButton)
                return reduceDidTapPrevButton(&state)
                
            case .didTapNextButton:
                logger.track(.cookingNextButton)
                return reduceDidTapNextButton(&state)
                
            case .didTapTimerButton:
                logger.track(.cookingTimerButton)
                return reduceDidTapTimerButton(&state)
                
            case .didTapVoiceButton:
                logger.track(.cookingVoiceButton)
                return reduceDidTapVoiceButton(&state)
                
            case .didTapSourceButton:
                logger.track(.cookingSourceButton)
                return reduceDidTapSourceButton(&state)
                
            case .didTapSpeakingButton:
                logger.track(.cookingSpeakingButton)
                if state.isPlaying {
                    state.destination = nil
                }
                
                let text = state.steps[state.currentStep].stepContent
                state.isSpeaking = true
                try? audioService.updateAudioSettings(for: .speaker)
                
                return .concatenate(
                    .send(.stopRecognizing),
                    .run { send in
                        await audioService.read(text: text)
                        await send(.didFinishReading)
                        await send(.startRecognizing)
                    }
                )
                
            case .didFinishReading:
                state.isSpeaking = false
                return .none
                
            case .requestAuthorization:
                return reduceRequestAuthorization(state)
                
            case .authorizationResult(let isGranted):
                return reduceAuthorizationResult(&state, isGranted: isGranted)
                
            case .startListening:
                return reduceStartListening(&state)
                
            case .startRecognizing:
                return reduceStartRecognizing(&state)
                
            case .stopRecognizing:
                return reduceStopRecognizing(&state)
                
            case .stopListening:
                return reduceStopListening(&state)
                
            case .receivedCommand(let voice):
                return reduceReceivedCommand(&state, voice: voice)
                
            case .destination(.dismiss):
                try? audioService.updateAudioSettings(for: .speaker)
                state.isPlaying = false
                return .none
                
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
        guard let startTime = state.startTime,
              let endTime = state.endTime else { return .none }
        
        try? audioService.updateAudioSettings(for: .earpiece)
        audioService.stopReading()
        state.destination = .player(
            .init(
                reference: state.reference,
                startTime: startTime,
                endTime: endTime
            )
        )
        state.isPlaying = true
        
        return .none
    }
}

private extension CookingReducer {
    func reduceRequestAuthorization(_ state: CookingReducer.State) -> Effect<Action> {
        return .run { send in
            let microPhonePermission = await audioService.requestMicrophonePermission()
            let recognitionPermission = await audioService.requestSpeechRecognitionPermission()
            let result = microPhonePermission && recognitionPermission
            
            await send(.authorizationResult(result))
        }
    }
    
    func reduceAuthorizationResult(_ state: inout CookingReducer.State, isGranted: Bool) -> Effect<Action> {
        if isGranted {
            state.hasSpeechPermission = true
            return .send(.startListening)
        }
        
        return .none
    }
}

private extension CookingReducer {
    func reduceStartListening(_ state: inout CookingReducer.State) -> Effect<Action> {
        state.isRecording = true
        state.isRecognizing = true
        guard !state.isSpeaking else { return .none }
        
        return .run { send in
            try await audioService.startCapture()
            await send(.startRecognizing)
        }
    }
    
    func reduceStartRecognizing(_ state: inout CookingReducer.State) -> Effect<Action> {
        guard state.isRecording,
              !state.isSpeaking else { return .none }
        
        state.isRecognizing = true
        
        if !state.isPlaying {
            try? audioService.updateAudioSettings(for: .speaker)
        }
        
        return .run { send in
            let result = await Result { try await audioService.getNextVoice() }
            switch result {
            case .success(let text):
                let command = parseVoiceCommand(from: text)
                let voice = VoiceVO(text: text, command: command)
                await send(.receivedCommand(voice))
            case .failure(let error):
                print(">>> error \(error)")
                await send(.startRecognizing)
            }
        }
    }
    
    func reduceStopListening(_ state: inout CookingReducer.State) -> Effect<Action> {
        audioService.stopCapture()
        audioService.stopVoiceRecognition()
        state.isRecognizing = false
        state.isRecording = false
        return .none
    }
    
    func reduceStopRecognizing(_ state: inout CookingReducer.State) -> Effect<Action> {
        audioService.stopVoiceRecognition()
        
        return .cancel(id: CancelID.speechRecognition)
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
            
        case .readStep:
            effects.append(.send(.didTapSpeakingButton))

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
                await send(.startRecognizing)
            }
            .cancellable(id: CancelID.speechRecognition)
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
    
    enum CancelID {
        case speechRecognition
    }
}

extension CookingReducer.Action {
    enum Delegate: Equatable {
        case navigateToResult
    }
}

private extension CookingReducer {
    func parseVoiceCommand(from text: String) -> VoiceCommandVO {
        let normalized = text.replacingOccurrences(of: " ", with: "")
        
        if let minutes = extractMinutes(from: normalized),
           let seconds = extractSeconds(from: normalized) {
            return .timer(minutes: minutes, seconds: seconds)
        }
        
        if let minutes = extractMinutes(from: normalized) {
            return .timer(minutes: minutes, seconds: 0)
        }
        
        if let seconds = extractSeconds(from: normalized) {
            return .timer(minutes: 0, seconds: seconds)
        }
        
        if ["이전", "뒤로"].contains(normalized) {
            return .previous
        }
        
        if ["다음", "앞으로"].contains(normalized) {
            return .next
        }
        
        if ["읽어줘", "레시피읽어줘", "단계읽어줘", "스텝읽어줘", "스탭읽어줘"].contains(normalized) {
            return .readStep
        }
        
        if ["영상보여줘", "영상틀어줘", "비디오틀어줘", "재생", "재생해줘", "틀어줘"].contains(normalized) {
            return .playVideo
        }
        
        if ["영상꺼줘", "비디오꺼줘", "정지", "정지해줘", "꺼줘"].contains(normalized) {
            return .stopVideo
        }
        
        if ["타이머꺼줘", "타이머취소"].contains(normalized) {
            return .stopTimer
        }
        
        return .unknown
    }
    
    func extractMinutes(from text: String) -> Int? {
        let pattern = #"타이머([가-힣0-9]+?)분"#
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        
        guard let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              let range = Range(match.range(at: 1), in: text)
        else { return nil }
        
        let captured = String(text[range])
        
        if let intVal = Int(captured) {
            return intVal
        }
        
        return koreanNumberToInt(captured)
    }
    
    func extractSeconds(from text: String) -> Int? {
        let pattern = #"타이머(?:[0-9가-힣]+분)?([0-9가-힣]+)초"#
        
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        
        guard let match = regex.firstMatch(in: text, range: NSRange(text.startIndex..., in: text)),
              let range = Range(match.range(at: 1), in: text) else { return nil }

        let captured = String(text[range])

        if let value = Int(captured) {
            return value
        }

        return koreanNumberToInt(captured)
    }
    
    func koreanNumberToInt(_ text: String) -> Int {
        let map: [String: Int] = [
            "영": 0, "일": 1, "이": 2, "삼": 3, "사": 4, "오": 5,
            "육": 6, "칠": 7, "팔": 8, "구": 9, "십": 10
        ]
        
        if text == "십" {
            return 10
        } else if text.hasPrefix("십") {
            let unit = String(text.dropFirst())
            return 10 + (map[unit] ?? 0)
        } else if text.hasSuffix("십") {
            let ten = String(text.dropLast())
            return (map[ten] ?? 1) * 10
        } else if text.contains("십") {
            let parts = text.split(separator: "십")
            let tens = map[String(parts[0])] ?? 1
            let ones = map[String(parts[1])] ?? 0
            return tens * 10 + ones
        } else {
            return map[text] ?? 0
        }
    }
}
