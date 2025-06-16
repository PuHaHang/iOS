//
//  CookingReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CookingReducer {
    @ObservableState
    struct State {
        let title: String
        let steps: [RecipeStepViewData]
        
        var currentStep: Int = 0
    }
    
    enum Action {
        case didTapPrevButton
        case didTapNextButton
        case didTapSourceButton
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapPrevButton:
                state.currentStep = max(0, state.currentStep - 1)
                return .none
                
            case .didTapNextButton:
                if state.currentStep + 1 == state.steps.count - 1 {
                    return .send(.delegate(.navigateToResult))
                } else if state.currentStep + 1 < state.steps.count - 1 {
                    state.currentStep = min(state.steps.count - 1, state.currentStep + 1)
                }
                return .none
                
            case .didTapSourceButton:
                print(">>> tap source")
                return .none
                
            case .delegate:
                return .none
            }
        }
    }
}

extension CookingReducer.Action {
    enum Delegate: Equatable {
        case navigateToResult
    }
}
