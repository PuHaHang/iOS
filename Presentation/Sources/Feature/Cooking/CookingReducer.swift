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
        @Presents var destination: Destination.State?
        
        let title: String
        let steps: [RecipeStepViewData]
        let reference: ReferenceViewData
        
        var currentStep: Int = 0
        
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
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
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
                state.destination = .player(
                    .init(
                        reference: state.reference,
                        startTime: state.startTime,
                        endTime: state.endTime
                    )
                )
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

extension CookingReducer {
    @Reducer
    enum Destination {
        case player(CookingPlayerReducer)
    }
}

extension CookingReducer.Action {
    enum Delegate: Equatable {
        case navigateToResult
    }
}
