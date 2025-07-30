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
    @Dependency(\.ingredientTodoService) var ingredientTodoService
    
    @ObservableState
    struct State {
        let recipeID: Int64
        var ingredients: IdentifiedArrayOf<IngredientItemReducer.State>
        
        init(recipeID: Int64, ingredients: [IngredientViewData]) {
            self.recipeID = recipeID
            self.ingredients = IdentifiedArrayOf(uniqueElements: ingredients.map {
                IngredientItemReducer.State(
                    id: $0.id,
                    name: $0.ingredient,
                    recipeID: recipeID,
                    isChecked: $0.isChecked
                )
            })
        }
    }
    
    enum Action {
        case onAppear
        case loadTodos
        case todosLoaded([String: Bool])
        case ingredients(IdentifiedActionOf<IngredientItemReducer>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .send(.loadTodos)
                
            case .loadTodos:
                return .run { [recipeID = state.recipeID] send in
                    let todos = await ingredientTodoService.getTodos(for: recipeID)
                    await send(.todosLoaded(todos))
                }
                
            case .todosLoaded(let todos):
                for (index, ingredient) in state.ingredients.enumerated() {
                    let isChecked = todos[String(ingredient.id)] ?? false
                    state.ingredients[index].isChecked = isChecked
                }
                
                let ingredientIDs = state.ingredients.map { $0.id }
                return .run { [recipeID = state.recipeID] _ in
                    await ingredientTodoService.initializeRecipe(
                        recipeID: recipeID,
                        ingredients: ingredientIDs
                    )
                }
                
            case .ingredients:
                return .none
            }
        }
        .forEach(\.ingredients, action: \.ingredients) {
            IngredientItemReducer()
        }
    }
}
