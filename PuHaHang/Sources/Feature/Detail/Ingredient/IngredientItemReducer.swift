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
    @ObservableState
    struct State: Identifiable {
        let id: Int
        let name: String
        var isChecked: Bool
    }
    
    enum Action {
        case didTapItem(Int)
        case toggleCheck
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTapItem:
                return .none
                
            case .toggleCheck:
                state.isChecked.toggle()
                return .none
            }
        }
    }
}
