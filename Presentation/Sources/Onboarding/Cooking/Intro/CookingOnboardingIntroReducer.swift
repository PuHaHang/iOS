//
//  CookingOnboardingIntroReducer.swift
//  Presentation
//
//  Created by 디해 on 7/22/25.
//

import ComposableArchitecture
import Foundation
import Shared

@Reducer
struct CookingOnboardingIntroReducer {
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingCookingIntroTitle
        let subTitleText: String = LocalizationHelper.onboardingCookingIntroSubtitle
        let introductionText: String = LocalizationHelper.onboardingCookingIntroIntroduction
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
