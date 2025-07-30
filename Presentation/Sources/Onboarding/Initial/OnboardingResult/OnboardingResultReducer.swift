//
//  OnboardingResultReducer.swift
//  Presentation
//
//  Created by 디해 on 7/16/25.
//

import ComposableArchitecture
import Foundation
import Shared

@Reducer
struct OnboardingResultReducer {
    @Dependency(\.launchOnboardingCompleteUseCase) var launchOnboardingCompleteUseCase
    
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingResultTitle
        let subTitleText: String = LocalizationHelper.onboardingResultSubtitle
        let imageURL: URL?
    }
    
    enum Action {
        case didTapStartButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapStartButton:
                launchOnboardingCompleteUseCase.execute()
                return .send(.delegate(.didRequestDismiss))
                
            case .delegate:
                return .none
            }
        }
    }
}

extension OnboardingResultReducer {
    enum Delegate {
        case didRequestDismiss
    }
}
