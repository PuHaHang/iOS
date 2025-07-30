//
//  CookingCompletionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/23/25.
//

import ComposableArchitecture
import Foundation
import Shared

@Reducer
struct CookingCompletionReducer {
    @Dependency(\.cookingOnboardingCompleteUseCase) var cookingOnboardingCompleteUseCase
    
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingCookingCompletionTitle
    }
    
    enum Action {
        case onAppear
        case didTapComfirmButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                cookingOnboardingCompleteUseCase.execute()
                return .none
            case .didTapComfirmButton:
                return .send(.delegate(.navigateToCooking))
            case .delegate:
                return .none
            }
        }
    }
}

extension CookingCompletionReducer {
    enum Delegate {
        case navigateToCooking
    }
}
