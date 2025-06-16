//
//  TitleTabReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/12/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct TitleTabReducer {
    @ObservableState
    struct State {
        let tabBarItems: [TitleTabBarItem] = [.steps, .ingredients]
        
        var selectedItem: TitleTabBarItem = .steps
    }
    
    enum Action {
        case didTabItem(TitleTabBarItem)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .didTabItem(let item):
                state.selectedItem = item
                return .none
            }
        }
    }
}
