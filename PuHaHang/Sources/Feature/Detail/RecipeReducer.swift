//
//  RecipeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/10/25.
//

import ComposableArchitecture
import Foundation
import UIKit

@Reducer
struct RecipeReducer {
    @ObservableState
    struct State {
        let recipeID: String
        let title: String
        let thumbnail: UIImage
        let serving: String
        let hasURL: Bool
        let steps: [RecipeStepViewData]
        let ingredients: [IngredientViewData]
        
        var path = StackState<Path.State>()
    }
    
    enum Action {
        case didTapContentButton
        case didTapCookingButton
        
        case path(StackActionOf<Path>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapContentButton:
                // TODO: - 원본 출처 연결
                return .none
                
            case .didTapCookingButton:
                state.path.append(.cooking(.init()))
                return .none
                
            case .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path.body
        }
    }
}

extension RecipeReducer {
    struct RecipeStepViewData {
        let stepTitle: String
        let stepContent: String
    }

    struct IngredientViewData {
        let ingredient: String
        let isChecked: Bool
    }
}

extension RecipeReducer {
    @Reducer
    enum Path {
        case cooking(CookingReducer)
    }
}
