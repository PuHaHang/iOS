//
//  HomeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import Entity
import UIKit

@Reducer
struct HomeReducer {
    @Dependency(\.fetchRecipePreviewsUseCase) var fetchRecipePreviewsUseCase
    
    @ObservableState
    struct State {
        let titleIconName: String = "title_icon"
        let pageSize: Int = 10
        var page: Int = 0
        
        var recipes: IdentifiedArrayOf<RecipeListItemReducer.State> = []
    }
    
    enum Action {
        case onAppear
        case addRecipe(RecipeListItem)
        case addRecipes([RecipeListItem])
        case recipes(IdentifiedActionOf<RecipeListItemReducer>)
        case refresh
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear(state)
                
            case .addRecipe(let item):
                return reduceAddRecipe(&state, item: item)
                
            case .addRecipes(let items):
                return reduceAddRecipes(&state, items: items)
                
            case .recipes(.element(id: _, action: .didTapItem(let item))):
                return .send(.delegate(.showRecipeDetail(item)))
                
            case .refresh:
                return reduceRefresh(&state)
                
            case .delegate:
                return .none
            }
        }
        .forEach(\.recipes, action: \.recipes) {
            RecipeListItemReducer()
        }
    }
}

private extension HomeReducer {
    func reduceOnAppear(_ state: HomeReducer.State) -> Effect<Action> {
        let page = state.page
        let pageSize = state.pageSize
        return .run { send in
            let result = await fetchRecipePreviewsUseCase.execute(
                page: page,
                pageSize: pageSize
            )
            
            switch result {
            case .success(let previews):
                let items = previews.map { $0.toRecipeListItem() }
                await send(.addRecipes(items))
            case .failure(let error):
                print(">>> Error: \(error)")
            }
        }
    }
    
    func reduceAddRecipe(
        _ state: inout HomeReducer.State,
        item: RecipeListItem
    ) -> Effect<Action> {
        let itemID = UUID()
        let itemState = RecipeListItemReducer.State(id: itemID, item: item)
        state.recipes.insert(itemState, at: 0)
        
        return .none
    }
    
    func reduceAddRecipes(
        _ state: inout HomeReducer.State,
        items: [RecipeListItem]
    ) -> Effect<Action> {
        for item in items.reversed() {
            let itemID = UUID()
            let itemState = RecipeListItemReducer.State(id: itemID, item: item)
            state.recipes.insert(itemState, at: 0)
        }
        return .none
    }
    
    func reduceRefresh(_ state: inout HomeReducer.State) -> Effect<Action> {
        state.page = 0
        state.recipes = []
        return .send(.onAppear)
    }
}

extension HomeReducer.Action {
    enum Delegate: Equatable {
        case showRecipeDetail(RecipeListItem)
    }
}

private extension RecipePreviewVO {
    func toRecipeListItem() -> RecipeListItem {
        return RecipeListItem(
            recipeID: self.recipeID,
            thumbnail: UIImage(),
            title: self.title,
            serving: "\(self.serving)인분",
            ingredients: self.ingredients.map { $0.name }.joined(separator: ", ")
        )
    }
}
