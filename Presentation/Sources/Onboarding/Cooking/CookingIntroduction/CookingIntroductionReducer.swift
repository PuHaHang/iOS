//
//  VoiceIntroductionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CookingIntroductionReducer {
    @ObservableState
    struct State {
        var introductionState: IntroductionState = .idle
        
        let skipIntroductionText: String = "화면을 눌러 넘어가주세요"
        
        var titleText: String {
            introductionState.titleText
        }
        
        var subTitleText: String? {
            introductionState.subTitleText
        }
        
        var introductionText: String? {
            let introduction = """
            마이크 버튼을 눌러
            음성 인식 기능을 끌 수 있어요.
            """
            
            return introductionState == .microphone ? introduction : nil
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
            case .microphone:
                """
                잘했어요!
                
                음성 인식은 계속 켜둘게요.
                """
            case .step:
                """
                이전 / 다음 단계로
                자유롭게 이동할 수 있어요.
                """
            case .play:
                """
                재생 버튼을 눌러
                원본 영상을 확인할 수 있어요.
                """
            case .timer:
                """
                요리 도중 필요한
                타이머를 설정할 수 있어요.
                """
            case .speaker:
                """
                읽어주기 기능으로
                설명을 음성으로 들을 수 있어요.
                """
            }
        }
        
        var subTitleText: String? {
            switch self {
            case .idle:
                nil
            case .microphone:
                nil
            case .step:
                """
                이전 / 뒤로
                다음 / 앞으로
                """
            case .play:
                """
                영상 틀어줘 / 비디오 보여줘 / 재생해줘
                영상 꺼줘 / 비디오 꺼줘 / 정지해줘
                """
            case .timer:
                """
                타이머 O분 O초
                타이머 취소 / 타이머 꺼줘
                """
            case .speaker:
                """
                읽어줘 / 레시피 읽어줘 / 스탭 읽어줘
                """
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
