//
//  HomeReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct HomeReducer {
    @ObservableState
    struct State: Equatable {
        let titleIconName: String = "title_icon"
    }
    
    enum Action: Equatable {
        case items(IdentifiedActionOf<RecipeListItemReducer>)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .items(.element(id: let id, action: .didTapItem)):
                print(">>> tapped item id: \(id)")
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            RecipeListItemReducer()
        }
    }
}
