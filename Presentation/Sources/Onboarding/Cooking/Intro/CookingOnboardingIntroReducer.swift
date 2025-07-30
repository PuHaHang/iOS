//
//  CookingOnboardingIntroReducer.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CookingOnboardingIntroReducer {
    @ObservableState
    struct State {
        let titleText: String = """
            레시핏과 함께
            첫 요리를 시작해볼까요?
            """
        
        let subTitleText: String = "이런 기능을 제공해요"
        let introductionText: String = """
            - 원본 영상/소스 보기
            - 음성 조작
            - 타이머 설정
            """
    }
    
    enum Action {
        case didTapStartButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapStartButton:
                return .send(.delegate(.navigateToVoicePermission))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension CookingOnboardingIntroReducer {
    enum Delegate {
        case navigateToVoicePermission
    }
}
