//
//  CookingReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import Foundation
import YouTubePlayerKit

@Reducer
struct CookingReducer {
    @ObservableState
    struct State {
        let title: String
        let steps: [RecipeStepViewData]
        let reference: ReferenceViewData
        
        var currentStep: Int = 0
        var isPlayerPresented: Bool = false
        
        var startTime: Measurement<UnitDuration> {
            steps[currentStep].timeline.startTime
        }
        
        var endTime: Measurement<UnitDuration> {
            steps[currentStep].timeline.endTime
        }
    }
    
    enum Action {
        case didTapPrevButton
        case didTapNextButton
        case didTapSourceButton
        case didTapPlayerBackground
        case endTimeReached
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapPrevButton:
                state.currentStep = max(0, state.currentStep - 1)
                return .none
                
            case .didTapNextButton:
                if state.currentStep + 1 >= state.steps.count {
                    return .send(.delegate(.navigateToResult))
                }  else {
                    state.currentStep = state.currentStep + 1
                }
                return .none
                
            case .didTapSourceButton:
                state.isPlayerPresented = true
                return .none
                
            case .didTapPlayerBackground:
                state.isPlayerPresented = false
                return .none
                
            case .endTimeReached:
                state.isPlayerPresented = false
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
