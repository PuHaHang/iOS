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
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapItem:
                return .none
                logger.track(.homeRecipeItemDeleteButton)
            }
        }
    }
}
