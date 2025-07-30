//
//  ConversionExampleReducer.swift
//  Presentation
//
//  Created by 디해 on 7/15/25.
//

import ComposableArchitecture
import Foundation
import Shared

@Reducer
struct ConversionExampleReducer {
    @ObservableState
    struct State {
        let titleText: String = LocalizationHelper.onboardingConversionExampleTitle
        let subTitleText: String = LocalizationHelper.onboardingConversionExampleSubtitle
        let exampleURL: String = LocalizationHelper.onboardingConversionExampleURL
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
