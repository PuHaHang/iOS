//
//  CookingCompletionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/23/25.
//

import ComposableArchitecture
import Foundation
import Shared
import Logger

@Reducer
struct CookingCompletionReducer {
    @Dependency(\.cookingOnboardingCompleteUseCase) var cookingOnboardingCompleteUseCase
    @Dependency(\.logger) var logger
    
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
                logger.track(.cookingOnboardingCompletionScreen)
                cookingOnboardingCompleteUseCase.execute()
                return .none
            case .didTapComfirmButton:
                logger.track(.cookingOnboardingCompletionConfirmButton)
                return .send(.delegate(.navigateToCooking))
            case .delegate:
                return .none
            }
        }
    }
}

extension CookingCompletionReducer {
    enum Delegate: Equatable {
        case navigateToCooking
    }
}
