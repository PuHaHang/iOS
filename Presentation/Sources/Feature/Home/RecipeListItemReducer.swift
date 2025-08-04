//
//  RecipeListItemReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import Foundation
import Logger

@Reducer
struct RecipeListItemReducer {
    @Dependency(\.deleteRecipeUseCase) var deleteRecipeUseCase
    @Dependency(\.logger) var logger
    
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        var item: RecipeListItem
        
        static func == (lhs: RecipeListItemReducer.State, rhs: RecipeListItemReducer.State) -> Bool {
            lhs.id == rhs.id
        }
    }
    
    enum Action: Equatable {
        case didTapItem(RecipeListItem)
        case didTapDeleteButton
        case delegate(Delegate)
    }
    
    var body: some ReducerOf<Self> {
        Reduce {
            state,
            action in
            switch action {
            case .didTapItem:
                return .none
            case .didTapDeleteButton:
                logger.track(.homeRecipeItemDeleteButton)
                
                let id = state.id
                return .run { send in
                    do {
                        try await deleteRecipeUseCase.execute(recipeID: id)
                        await send(.delegate(.deleteRequested), animation: .default)
                    } catch {
                        let errorType = ErrorDisplayType.toast(
                            message: "데이터 삭제에 실패했습니다.\n잠시 후 다시 시도해주세요.",
                            duration: 3.0
                        )
                        await send(.delegate(.showError(errorType)))
                    }
                }
                
            case .delegate:
                return .none
            }
        }
    }
}

extension RecipeListItemReducer {
    enum Delegate: Equatable {
        case deleteRequested
        case showError(ErrorDisplayType)
    }
}
