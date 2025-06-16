//
//  HomeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
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
        case recipes(IdentifiedActionOf<RecipeListItemReducer>)
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear(state)
            case .addRecipes(let items):
                return reduceAddRecipes(&state, items: items)
                
            case .recipes(.element(id: _, action: .didTapItem(let item))):
                return .send(.delegate(.showRecipeDetail(item)))
                
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
}

extension HomeReducer.Action {
    enum Delegate: Equatable {
        case showRecipeDetail(RecipeListItem)
    }
}

private extension RecipePreview {
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
