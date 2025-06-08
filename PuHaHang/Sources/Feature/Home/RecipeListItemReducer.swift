//
//  RecipeListItemReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/8/25.
//

import ComposableArchitecture
import UIKit

@Reducer
struct RecipeListItemReducer {
    @ObservableState
    struct State: Equatable, Identifiable {
        let id: UUID
        let thumbnail: UIImage
        let title: String
        let serving: String
        let ingredients: String
    }
    
    enum Action: Equatable {
        case didTapItem
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapItem:
                return .none
            }
        }
    }
}
