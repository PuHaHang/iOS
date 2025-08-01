//
//  IntroductionReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation
import Shared
import Logger

@Reducer
struct IntroductionReducer {
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingIntroductionTitle
        let subTitleText: String = LocalizationHelper.onboardingIntroductionSubtitle
    }
    
    enum Action {
        case onAppear
        case didTapNextButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.onboardingIntroductionScreen)
                return .none
                
            case .didTapNextButton:
                logger.track(.onboardingIntroductionNextButton)
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
