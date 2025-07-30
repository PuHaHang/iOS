//
//  ConversionResultReducer.swift
//  Presentation
//
//  Created by 디해 on 7/12/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct ConversionResultReducer {
    @ObservableState
    struct State: Equatable {
        let recipePreviewViewData: RecipePreviewViewData
    }
    
    enum Action: Equatable {
        case didTapComfirmButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapComfirmButton:
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
