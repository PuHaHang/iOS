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
        
    }
    
    enum Action: Equatable {
        
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            return .none
        }
    }
}
