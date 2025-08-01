//
//  ConversionResultReducer.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Foundation
import Logger

@Reducer
struct ConversionResultReducer {
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State: Equatable {
        let recipePreviewViewData: RecipePreviewViewData
    }
    
    enum Action: Equatable {
        case onAppear
        case didTapComfirmButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                logger.track(.conversionResultScreen)
                return .none
                
            case .didTapComfirmButton:
                logger.track(.conversionResultConfirmButton)
                return .send(.delegate(.didRequestDismiss))
            case .delegate:
                return .none
            }
        }
    }
}

extension ConversionResultReducer {
    enum Delegate {
        case didRequestDismiss
    }
}
