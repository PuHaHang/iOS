//
//  HomeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation
import Entity
import Logger
import Shared
import UIKit

@Reducer
struct HomeReducer {
    @Dependency(\.incompletedRecipeIDStore) var incompletedRecipeIDStore
    @Dependency(\.fetchRecipePreviewsUseCase) var fetchRecipePreviewsUseCase
    @Dependency(\.fetchRecipePreviewUseCase) var fetchRecipePreviewUseCase
    @Dependency(\.fetchCompletedRecipeConversionIDsUseCase) var fetchCompletedRecipeConversionIDsUseCase
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State {
        let titleIconName: String = "title_icon"
        let pageSize: Int = 3
        var cursorId: Int?
        var hasNext: Bool = false
        var isLoadingNext: Bool = false
        
        var recipes: IdentifiedArrayOf<RecipeListItemReducer.State> = []
        var listState: RecipeListState = .idle
        
        var errorState = ErrorHandlingState()
    }
    
    enum Action {
        case onAppear
        case addRecipe(RecipeListItem)
        case updateRecipe(RecipeListItem)
        case addRecipes([RecipeListItem])
        case checkIfNeedsPolling
        case recipes(IdentifiedActionOf<RecipeListItemReducer>)
        case refresh
        case scroll
        case updatePageState(Bool, Int?)
        case addConvertingId(Int64)
        case startPolling
        case pollTick
        case cancelTick
        case completedRecipeIDsRepsponse([Int64])
        
        case showError(ErrorDisplayType)
        case clearError
        
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .onAppear:
                logger.track(.homeScreen)
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
                logger.track(.homeRecipeItemButton(servings: item.servings))
                return .send(.delegate(.showRecipeDetail(item)))
                
            case .recipes(.element(id: _, action: .delegate(.showError(let errorType)))):
                return .send(.showError(errorType))
                
            case .recipes(.element(id: let recipeId, action: .delegate(.deleteRequested))):
                state.recipes.remove(id: recipeId)
                state.listState = state.recipes.isEmpty ? .empty : .loaded
                return .none
                
            case .recipes:
                return .none
                
            case .refresh:
                return reduceRefresh(&state)
                
            case .addConvertingId(let recipeId):
                return .run { send in
                    await incompletedRecipeIDStore.add(recipeId)
                    await send(.startPolling)
                }
                
            case .updatePageState(let hasNext, let cursorId):
                state.cursorId = cursorId
                state.hasNext = hasNext
                state.isLoadingNext = false
                return .none
                
            case .scroll:
                guard state.hasNext,
                      !state.isLoadingNext,
                      let cursorId = state.cursorId else { return .none }
                state.isLoadingNext = true
                let pageSize = state.pageSize
                
                return .run { send in
                    let result = await fetchRecipePreviewsUseCase.execute(cursorId: cursorId, size: pageSize)
                    
                    switch result {
                    case .success(let list):
                        let hasNext = list.hasNext
                        let cursorId = list.cursorId
                        let items = list.previews.map { $0.toRecipeListItem() }
                        
                        await send(.updatePageState(hasNext, cursorId))
                        await send(.addRecipes(items))
                        await send(.checkIfNeedsPolling)
                        
                    case .failure(let error):
                        let errorType = ErrorDisplayType.toast(
                            message: "데이터 로드에 실패했습니다.",
                            duration: 3.0
                        )
                        await send(.showError(errorType))
                    }
                }
                
            case .checkIfNeedsPolling:
                return .run { [recipes = state.recipes] send in
                    var needsPolling = false
                    
                    for recipeState in recipes {
                        let item = recipeState.item
                        if item.state != .completed && item.state != .failed {
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
                    
                    
                    do {
                        let result = try await fetchCompletedRecipeConversionIDsUseCase.execute(ids: ids)
                        await send(.completedRecipeIDsRepsponse(result))
                    } catch {
                        print(">>> \(error)")
                    }
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
                
            case .showError(let errorType):
                state.errorState.showError(errorType)
                return .none
                
            case .clearError:
                state.errorState.clearError()
                return .none
                
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
        state.cursorId = nil
        state.recipes = []
        state.listState = .idle
        state.errorState.clearError()
        
        let pageSize = state.pageSize
        
        return .run { send in
            let result = await fetchRecipePreviewsUseCase.execute(cursorId: nil, size: pageSize)
            
            switch result {
            case .success(let list):
                let hasNext = list.hasNext
                let cursorId = list.cursorId
                let items = list.previews.map { $0.toRecipeListItem() }
                
                await send(.updatePageState(hasNext, cursorId))
                await send(.addRecipes(items))
                await send(.checkIfNeedsPolling)
                
            case .failure(let error):
                let errorType = ErrorDisplayType.dialog(
                    title: "오류가 발생하였습니다",
                    message: "인터넷 연결 상태를 확인하고 다시 시도해주세요.",
                    showBackButton: false
                )
                
                await send(.showError(errorType))
            }
        }
    }
    
    func reduceAddRecipe(
        _ state: inout HomeReducer.State,
        item: RecipeListItem
    ) -> Effect<Action> {
        let itemState = RecipeListItemReducer.State(item: item)
        state.recipes.insert(itemState, at: 0)
        
        return .none
    }
    
    func reduceAddRecipes(
        _ state: inout HomeReducer.State,
        items: [RecipeListItem]
    ) -> Effect<Action> {
        for item in items {
            let itemState = RecipeListItemReducer.State(item: item)
            state.recipes.append(itemState)
        }
        state.listState = state.recipes.isEmpty ? .empty : .loaded
        return .none
    }
    
    func reduceRefresh(_ state: inout HomeReducer.State) -> Effect<Action> {
        state.cursorId = nil
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
            servings: self.servings,
            ingredients: self.ingredients.map { $0.name }.joined(separator: ", "),
            state: self.state.toRecipeStateViewData()
        )
    }
}
