//
//  CookingReducer.swift
//  PuHaHang
//
//  Created by 디해 on 6/11/25.
//

import ComposableArchitecture
import Foundation

@Reducer
struct CookingReducer {
    @ObservableState
    struct State {
        
    }
    
    enum Action {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
