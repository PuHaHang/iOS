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
        let recipeViewData: RecipeViewData
        
        var path = StackState<Path.State>()
        var titleTab: TitleTabReducer.State
        
        init(recipeViewData: RecipeViewData) {
            self.recipeViewData = recipeViewData
            self.titleTab = TitleTabReducer.State(
                steps: recipeViewData.steps,
                ingredients: recipeViewData.ingredients
            )
        }
    }
    
    enum Action {
        case didTapContentButton
        case didTapCookingButton
        
        case path(StackActionOf<Path>)
        case titleTab(TitleTabReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.titleTab, action: \.titleTab) {
            TitleTabReducer()
        }
        
        Reduce { state, action in
            switch action {
            case .didTapContentButton:
                // TODO: - 원본 출처 연결
                return .none
                
            case .didTapCookingButton:
                state.path.append(.cooking(.init()))
                return .none
                
            case .path, .titleTab:
                return .none
            }
        }
        .forEach(\.path, action: \.path) {
            Path.body
        }
    }
}

extension RecipeReducer {
    @Reducer
    enum Path {
        case cooking(CookingReducer)
    }
}
