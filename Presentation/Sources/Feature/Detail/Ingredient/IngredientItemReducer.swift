//
//  IngredientItemReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/13/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct IngredientItemReducer {
    @Dependency(\.ingredientTodoService) var ingredientTodoService
    
    @ObservableState
    struct State: Identifiable {
        let id: Int64
        let name: String
        let recipeID: Int64
        var isChecked: Bool
        
        var errorState = ErrorHandlingState()
    }
    
    enum Action {
        case didTapItem(Int64)
        case toggleCheck
        
        case showError(ErrorDisplayType)
        case clearError
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapItem:
                return .send(.toggleCheck)
                
            case .toggleCheck:
                state.isChecked.toggle()
                
                return .run { [
                    id = state.id,
                    isChecked = state.isChecked,
                    recipeID = state.recipeID
                ] send in
                    do {
                        try await ingredientTodoService.setTodo(
                            ingredientID: id,
                            isCompleted: isChecked,
                            for: recipeID)
                    } catch {
                        let errorType = ErrorDisplayType.toast(
                            message: "목록을 저장하는 데 실패했습니다.",
                            duration: 3.0
                        )
                        await send(.showError(errorType))
                    }
                }
                
            case .showError(let errorType):
                state.errorState.clearError()
                return .none
                
            case .clearError:
                state.errorState.clearError()
                return .none
            }
        }
    }
}
