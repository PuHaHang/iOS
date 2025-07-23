//
//  ConversionExampleReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ConversionExampleReducer {
    @ObservableState
    struct State {
        let titleText: String = "직접 해볼까요?"
        let subTitleText: String = """
            레시핏이 예시를 미리 넣어뒀어요.
            <변환하기> 버튼을 눌러보세요.
            """
        let exampleURL: String = "https://www.youtube.com/watch?v=7F-cUfGQK1w"
    }
    
    enum Action {
        case didTapConvertButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapConvertButton:
                return .send(.delegate(.navigateToConversionProcess))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension ConversionExampleReducer {
    enum Delegate {
        case navigateToConversionProcess
    }
}
