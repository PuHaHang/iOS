//
//  HomeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import Entity
import Shared
import UIKit

@Reducer
struct HomeReducer {
    @Dependency(\.incompletedRecipeIDStore) var incompletedRecipeIDStore
    @Dependency(\.fetchRecipePreviewsUseCase) var fetchRecipePreviewsUseCase
    @Dependency(\.fetchRecipePreviewUseCase) var fetchRecipePreviewUseCase
    @Dependency(\.fetchCompletedRecipeConversionIDsUseCase) var fetchCompletedRecipeConversionIDsUseCase
    
    @ObservableState
    struct State {
        let titleIconName: String = "title_icon"
        let pageSize: Int = 10
        var page: Int = 1
        
        var recipes: IdentifiedArrayOf<RecipeListItemReducer.State> = []
        var listState: RecipeListState = .idle
    }
    
    enum Action {
        case onAppear
        case addRecipe(RecipeListItem)
        case updateRecipe(RecipeListItem)
        case addRecipes([RecipeListItem])
        case checkIfNeedsPolling
        case recipes(IdentifiedActionOf<RecipeListItemReducer>)
        case refresh
        case addConvertingId(Int64)
        case startPolling
        case pollTick
        case cancelTick
        case completedRecipeIDsRepsponse([Int64])
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return reduceOnAppear(&state)
                
            case .addRecipe(let item):
                return reduceAddRecipe(&state, item: item)
                
            case .updateRecipe(let item):
                if let index = state.recipes.firstIndex(where: { $0.item.recipeID == item.recipeID }) {
                    state.recipes[index].item = item
                }
                return .none
                
            case .addRecipes(let items):
                return reduceAddRecipes(&state, items: items)
                
            case .recipes(.element(id: _, action: .didTapItem(let item))):
                return .send(.delegate(.showRecipeDetail(item)))
                
            case .refresh:
                return reduceRefresh(&state)
                
            case .addConvertingId(let recipeId):
                return .run { send in
                    await incompletedRecipeIDStore.add(recipeId)
                    await send(.startPolling)
                }
                
            case .checkIfNeedsPolling:
                return .run { [recipes = state.recipes] send in
                    var needsPolling = false
                    
                    for recipeState in recipes {
                        let item = recipeState.item
                        if item.state != .completed {
                            await incompletedRecipeIDStore.add(item.recipeID)
                            needsPolling = true
                        }
                    }

                    if needsPolling {
                        await send(.startPolling)
                    }
                }
                
            case .startPolling:
                return .run { send in
                    for await _ in Timer
                        .publish(every: 5, on: .main, in: .common)
                        .autoconnect()
                        .values {
                        await send(.pollTick)
                    }
                }
                .cancellable(id: CancelID.polling)
                
            case .pollTick:
                return .run { send in
                    let ids = await incompletedRecipeIDStore.get()
                    guard !ids.isEmpty else { return await send(.cancelTick) }
                    
                    guard let result = try? await fetchCompletedRecipeConversionIDsUseCase.execute(ids: ids) else { return }
                    
                    await send(.completedRecipeIDsRepsponse(result))
                }
                
            case .completedRecipeIDsRepsponse(let ids):
                return .run { send in
                    await incompletedRecipeIDStore.remove(ids)
                    
                    for id in ids {
                        let result = await fetchRecipePreviewUseCase.execute(recipeID: id)
                        
                        switch result {
                        case .success(let preview):
                            let item = preview.toRecipeListItem()
                            await send(.updateRecipe(item))
                        case .failure:
                            continue
                        }
                    }
                }

            case .cancelTick:
                return .cancel(id: CancelID.polling)
                
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
    func reduceOnAppear(_ state: inout HomeReducer.State) -> Effect<Action> {
        state.page = 1
        state.recipes = []
        
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
                await send(.checkIfNeedsPolling)
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
        state.listState = state.recipes.isEmpty ? .empty : .loaded
        return .none
    }
    
    func reduceRefresh(_ state: inout HomeReducer.State) -> Effect<Action> {
        state.page = 1
        state.recipes = []
        return .send(.onAppear)
    }
}

extension HomeReducer {
    enum CancelID {
        case polling
    }
    
    enum Delegate: Equatable {
        case showRecipeDetail(RecipeListItem)
    }
    
    enum RecipeListState {
        case idle
        case loaded
        case empty
    }
}

private extension RecipePreviewVO {
    func toRecipeListItem() -> RecipeListItem {
        return RecipeListItem(
            recipeID: self.recipeID,
            thumbnail: self.thumbnailURL,
            title: self.title,
            serving: "\(self.servings)\(LocalizationHelper.recipeServingUnit)",
            ingredients: self.ingredients.map { $0.name }.joined(separator: ", "),
            state: self.state.toRecipeStateViewData()
        )
    }
}
