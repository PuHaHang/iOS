//
//  OnboardingResultReducer.swift
//  Presentation
//
//  Created by 디해 on 7/16/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct OnboardingResultReducer {
    @Dependency(\.launchOnboardingCompleteUseCase) var launchOnboardingCompleteUseCase
    
    @ObservableState
    struct State {
        let titleText: String = "레시피가 완성되었어요!"
        let subTitleText: String = """
            이제 레시핏과 함께
            요리를 시작해볼까요?
            """
        let recipePreviewViewData: RecipePreviewViewData
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
