//
//  TitleTabReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct TitleTabReducer {
    @ObservableState
    struct State {
        let tabBarItems: [TitleTabBarItem] = [.steps, .ingredients]
        var selectedItem: TitleTabBarItem = .steps
        
        var recipeStep: RecipeStepReducer.State
        var recipeIngredient: RecipeIngredientReducer.State
        
        init(steps: [RecipeStepViewData], ingredients: [IngredientViewData]) {
            self.recipeStep = RecipeStepReducer.State(steps: steps)
            self.recipeIngredient = RecipeIngredientReducer.State(ingredients: ingredients)
        }
    }
    
    enum Action {
        case didTabItem(TitleTabBarItem)
        case recipeStep(RecipeStepReducer.Action)
        case recipeIngredient(RecipeIngredientReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.recipeStep, action: \.recipeStep) {
            RecipeStepReducer()
        }
        
        Scope(state: \.recipeIngredient, action: \.recipeIngredient) {
            RecipeIngredientReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .didTabItem(let item):
                state.selectedItem = item
                return .none
                
            case .recipeStep, .recipeIngredient:
                return .none
            }
        }
    }
}
