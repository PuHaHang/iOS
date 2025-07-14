//
//  RecipeIngredientReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct RecipeIngredientReducer {
    @ObservableState
    struct State {
        var ingredients: IdentifiedArrayOf<IngredientItemReducer.State>
        
        init(ingredients: [IngredientViewData]) {
            self.ingredients = IdentifiedArrayOf(uniqueElements: ingredients.map {
                IngredientItemReducer.State(
                    id: $0.id,
                    name: $0.ingredient,
                    isChecked: $0.isChecked
                )
            })
        }
    }
    
    enum Action {
        case ingredients(IdentifiedActionOf<IngredientItemReducer>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .ingredients(.element(id: let id, action: .didTapItem)):
                return .send(.ingredients(.element(id: id, action: .toggleCheck)))
                
            case .ingredients:
                return .none
            }
        }
        .forEach(\.ingredients, action: \.ingredients) {
            IngredientItemReducer()
        }
    }
}
