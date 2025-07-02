//
//  TabReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/6/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct TabReducer {
    @ObservableState
    struct State: Equatable {
        var tab: Tab = .home
    }
    
    enum Action: Equatable {
        case didTabPlusButton
        case didTabItem(Tab)
        case tabChanged(Tab)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTabItem(let tab):
                state.tab = tab
                return .none
                
            case .didTabPlusButton:
                return .none
                
            case .tabChanged:
                return .none
            }
        }
    }
}
