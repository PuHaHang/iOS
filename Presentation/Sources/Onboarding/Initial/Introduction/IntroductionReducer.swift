//
//  IntroductionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct IntroductionReducer {
    @ObservableState
    struct State {
        let titleText: String = """
            요리하고 싶은 영상이나 글을 넣으면
            레시피로 바꿔드릴게요.
            """
        let subTitleText: String = "(유튜브 영상, 쇼츠, 텍스트를 지원해요.)"
    }
    
    enum Action {
        case didTapNextButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapNextButton:
                return .send(.delegate(.navigateToConversionExample))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension IntroductionReducer {
    enum Delegate {
        case navigateToConversionExample
    }
}
